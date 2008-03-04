function Matrix(rows,cols,data)
{
 if (typeof rows == "string") // "0 1, 1 0"
 {
  var s = rows.split(',');
  this.rows = s.length;
  this.data = rows.replace(/(^\s+|\s+$)/g,'').split(/[,\s]+/g)
  this.cols = Math.floor(this.data.length / this.rows)
  for (var i in this.data)
  {
   this.data[i] = Number(this.data[i])
  }
 }
 else
 {
   this.rows = rows
   this.cols = cols
   if (typeof data == "undefined") this.data = new Array;
   else this.data = data
 }
}

Matrix.prototype.toSource = function()
{
 return '(new Matrix('+this.rows+','+this.cols+','+this.data.toSource()+'))';
}

Matrix.prototype.zero = function()
{
 var max = this.rows *  this.cols;
 for (var r=0; r<max; r++)
  this.data[r] = 0;  
}

Matrix.identity = function(s)
{
 m = new Matrix(s,s)
 m.zero();
 for (var r=0; r < s; r++)
  m.set(r,r,1)
 return m
}

//indexes start at zero
Matrix.prototype.at = function (r,c)
{
 return this.data[r*this.cols + c];
}

Matrix.prototype.get = function (r,c)
{
 return this.data[r*this.cols + c];
}

Matrix.prototype.put = function (r,c,x)
{
 this.data[r*this.cols + c]=x;
}

Matrix.prototype.set = function (r,c,x)
{
 this.data[r*this.cols + c]=x;
}

Matrix.prototype.toString = function()
{
 var s = "";
 for (var r=0; r<this.rows; r++)
 {
  for (var c =0; c<this.cols; c++)
 { 
   s += this.at(r,c) + '\t'
 }
  s += '\n'
 }
 return s
}

Matrix.prototype.copy = function()
{
 return new Matrix(this.rows,this.cols,this.data.concat());
}

Matrix.prototype.transpose = function ()
{
 data = [];
 for (var c =0; c<this.cols; c++)
  for (var r=0; r<this.rows; r++)
  {
    data.push(this.at(r,c));
 }
 return new Matrix(this.cols,this.rows,data);
}
Matrix.prototype.times = function (other)
{
 data = [];
 
 if ((typeof other) == "number") //multiplication
 {
   for (var i in this.data) data[i]=this.data[i] * other;
   return new Matrix(this.rows,this.cols,data);
 }
 
 if (this.cols != other.rows) throw "Matrix mismatch";
 for (var r=0; r<this.rows; r++)
  for (var c =0; c<other.cols; c++)
  {
   var x = 0;
   for (var d =0; d<this.cols; d++) 
     x += this.at(r,d) * other.at(d,c)
   data.push(x);
 }
 
 return new Matrix(this.rows,other.cols,data);
}

/** Given a square matrix S and vector Y, returns X such that S . X = Y */
Matrix.solve = function(S,Y)
{
  //adapted from http://home.att.net/~srschmitt/
  //eliminate
  var i, j, k;
  N = S.rows;
  if (N != S.cols) throw "S must be a square matrix";
  if (N != Y.rows) throw "Y must be a " + N + "x1 matrix";
  
  var A = new Matrix(S.rows, S.cols + Y.cols)
  
  for (i = 0; i < S.rows; i++)
  {
    A.put(i, S.cols, Y.at(i,0))
    for (j = 0; j < S.cols; j++)
      A.put(i, j, S.at(i,j))    
  }

  for (i = 0; i < N; i++)
  {
    // find row with maximum in column i
    var max_row = i;
    for (j = i; j < N; j++)
    {
     if (Math.abs(A.at(j,i)) > Math.abs(A.at(max_row,i)))
       max_row = j;
    }

    // swap max row with row i of [A:y]
    for (k = i; k < N + 1; k++)
    {
     var tmp       = A.at(i,k);
     A.put(i,k, A.at(max_row,k));
     A.put(max_row, k, tmp);
    }

    // eliminate lower diagonal elements of [A]
    for (j = i + 1; j < N; j++)
    {
      for (k = N; k > i; k--)
      {
       if (A.at(i,i) == 0.0)
         return false;
       else
         A.put(j,k, A.at(j,k) - A.at(i,k)*A.at(j,i)/A.at(i,i));
      }
    }
  }

  //substitute
  var X = new Matrix(Y.rows, Y.cols); //cols should be 1
  X.zero();

  for (j = N - 1; j >= 0; j--)
  {
    var sum = 0.0;
    for (k = j+1; k < N; k++)
      sum += A.at(j,k)*X.at(k,0);

    X.put(j, 0, (A.at(j,N) - sum)/A.at(j,j));
  }
return X;
}

Matrix.fit = function(order,data)
{
 //data = [ [x1, y1], [x2, y2], [x3,y3] ]
 var N = data.length
 if (!order) throw "Matrix.fit missing parameter: order"
 var s = new Matrix(order+1,order+1)
 s.zero()
 
 var x = new Array(2*order +1); //[0,0,0,0,0]
 for (var i=0; i< x.length; i++)
  x[i] = 0;
 
 var xy = new Array(order+1); //[0,0,0]
 for (var i=0; i < xy.length; i++)
  xy[i] = 0;
 
 for (var d in data)
 {
  var a = data[d][0]
  var b = 1
  var c = data[d][1]
  for (var j=0; j< x.length; j++)
  {
   x[j] += b
   b = b * a
  }
  for (var j=0; j< xy.length; j++)
  {
   xy[order-j] += c
   c = c * a
  }   
 }

 var y = new Matrix(xy.length,1,xy)
 
 for (var i=0; i<s.rows; i++)
 for (var j=0; j<s.cols; j++)
 {
  s.put(i, j, x[x.length - 1 - i - j ])
 }
 
 var ret = Matrix.solve(s,y).data
 ret.reverse()
 return ret;
}

Matrix.test = function()
{
  i = Matrix.identity(3);
  writeln('i = Matrix.identity(3):');
  writeln(i);
  
  writeln('i.toSource():');
  writeln(i.toSource());
  writeln()
  
  writeln('eval(i.toSource()):');  
  writeln(eval(i.toSource()));
  
  a = new Matrix(3,2,[1,0,1,1,1,2])
  b = new Matrix(3,1,[6,0,0])
  aT = a.transpose()
  writeln('a = new Matrix(3,2,[1,0,1,1,1,2])');
  writeln(a);

  writeln('b = new Matrix(3,1,[6,0,0])');
  writeln(b);

  writeln('Matrix.times(aT,b): 6 / 0 ')
  writeln(aT.times(b))

  writeln('Matrix.times(aT,a): 3 3 / 3 5')
  writeln(aT.times(a))

  writeln('Given a square matrix S and vector Y, find X such that S . X = Y')
  writeln('s = new Matrix(3,3,[1,1,-1,1,2,1,2,-1,1])')
  writeln('y = new Matrix(3,1,[0,8,3])')
  writeln('x = Matrix.solve(s,y)')
  s = new Matrix(3,3,[1,1,-1,1,2,1,2,-1,1])
  y = new Matrix(3,1,[0,8,3])
  x = Matrix.solve(s,y)
  writeln(x)

  writeln('Matrix.fit(): Curve fit to 4 x^2 + 50 x -40') // 1,0,1
  writeln('x = Matrix.fit(2,[[9,734],[3,146],[-12,-64]]')
  x = Matrix.fit(2,[[9,734],[3,146],[-12,-64]])
  writeln(x)

  writeln('Matrix.fit(): Curve fit to 2 x^3 + 5 x^2 + 7 x -13') 
  x = Matrix.fit(3,[[5,397],[8,1387],[0,-13],[-12,-2833]]) //[[0,1],[-1,2],[1,2]]) 
  writeln(x)
}
