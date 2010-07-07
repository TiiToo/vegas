//Solve   adapted from http://home.att.net/~srschmitt/
function Matrix(rows,cols,data)
{
 if (typeof rows == "string") // "0 1, 1 0"
 {
  let s = rows.split(',');
  this.rows = s.length;
  this.data = rows.replace(/(^\s+|\s+$)/g,'').split(/[,\s]+/g)
  this.cols = Math.floor(this.data.length / this.rows)
  for (let i in this.data)
  {
   this.data[i] = Number(this.data[i])
  }
 }
 else if (typeof rows == "object" && (rows.length || false))
 {
   this.rows = rows.length
   this.cols = rows[0].length
   this.data = new Array
   for (let i=0; i< rows.length; i++) 
   {
    this.data = this.data.concat(rows[i])
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
 let max = this.rows *  this.cols;
 for (let r=0; r<max; r++)
  this.data[r] = 0;  
}

Matrix.identity = function(s)
{
 m = new Matrix(s,s)
 m.zero();
 for (let r=0; r < s; r++)
  m.set(r,r,1)
 return m
}

Matrix.diagonal = function(s)
{
 m = new Matrix(s.length,s.length)
 m.zero();
 for (let r=0; r < m.rows; r++)
  m.set(r,r,s[r])
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
 let s = "";
 for (let r=0; r<this.rows; r++)
 {
  for (let c =0; c<this.cols; c++)
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
 data = new Array(this.rows * this.cols);
 let i=0;
 for (let c =0; c<this.cols; c++)
  for (let r=0; r<this.rows; r++)
  {
    data[i++] = this.at(r,c);
 }
 return new Matrix(this.cols,this.rows,data);
}

Matrix.prototype.times = function (other)
{
 data = new Array(this.rows * other.cols)
 let i=0
 let x
 if ((typeof other) == "number") //multiplication
 {
   for (i = 0; i < this.data.length; i++) data[i]=this.data[i] * other;
   return new Matrix(this.rows,this.cols,data);
 }
 i = 0
 if (this.cols != other.rows) throw "Matrix mismatch";
 for (let r=0; r<this.rows; r++)
  for (let c =0; c<other.cols; c++)
  {
   x = 0;
   for (let d =0; d<this.cols; d++)
     x += this.at(r,d) * other.at(d,c)
   data[i++] = (x);
 }
 
 return new Matrix(this.rows,other.cols,data);
}

Matrix.prototype.scale = function (other)
{
 let data = new Array(this.data.length)
 if (this.cols != other.cols || this.rows != other.rows) throw "Matrix mismatch";
 
 for (let i = 0; i<this.data.length; i++) data[i]=this.data[i] * other.data[i];
 return new Matrix(this.rows,this.cols,data);
}

Matrix.prototype.reciprocal = function ()
{
 let data = new Array(this.data.length)
 for (let i = 0; i<this.data.length; i++) data[i] = (this.data[i] != 0) ? 1/this.data[i] : 0.0
 return new Matrix(this.rows,this.cols,data);
}

Matrix.prototype.swapRows = function( row1, row2 )
{
 let t
 for (let i = 0; i< this.cols; i++)
 {
  t = this.get(row1, i)
  this.set(row1, i, this.get(row2, i))
  this.set(row2, i , t)
 }
}

Matrix.prototype.swapCols = function( col1, col2 )
{
 let t
 for (let i = 0; i< this.rows; i++)
 {
  t = this.get(i, col1)
  this.set(i, col1, this.get(i, col2))
  this.set(i, col2 , t)
 }
}

Matrix.prototype.round = function(precision)
{
  for (let i = 0; i<this.data.length; i++)
   data[i] = Math.round(this.data[i])
 return new Matrix(this.rows,this.cols,data);
}

Matrix.prototype.inverse = function(precision)
{//Gauss-Jordan elimination for a square matrix
   if (this.rows != this.cols) throw "Not square"
    
    let t = Matrix.identity(this.cols)
    let m = this.copy()
    let rank = this.rows

    function scale(m, row, value)
    {
      for (let i = 0; i< m.cols; i++)
        m.set(row, i, m.get(row, i) * value)
    }
    function combineRows(m, a, b, value)
    {
      for (let i = 0; i< m.cols; i++)
        m.set(a, i, m.get(a, i) + (value * m.get( b, i)))
    }

    if (!precision) precision = 1.0E-12
    else precision = Math.abs(precision)

    let i,j,d,pos
    for (pos =0; pos < rank; pos++)
    {
        d = m.get(pos, pos)

        if (Math.abs(d) <= precision) //done
        {
            m.set(pos,pos,0)
            break
        }

        //scale rows
        d = 1/d
        scale(m, pos, d)
        scale(t, pos, d)    

        //subtract down
        for (j = pos+1; j < m.rows; j++)
        {
          d = m.get(j, pos)
          if (Math.abs(d) > precision)
          {
           combineRows(m, j, pos, -d)
           combineRows(t, j, pos, -d)
          }    
        }
    }

    //backsubstitution on upper triangle
    for (let j = rank - 1; j > 0; j--)
     for (let i = 0; i < j; i++)
     {
      d = m.get(i, j)
      combineRows(m, i, j, -d)
      combineRows(t, i, j, -d)
     }
    return t
}

/*
Translated from http://stitchpanorama.sourceforge.net/Python/svd.py

Here is the test case (first example) from Golub and Reinsch

a= new Matrix(8,5,[
    22.,10., 2.,  3., 7.,
    14., 7.,10.,  0., 8.,
    -1.,13.,-1.,-11., 3.,
    -3.,-2.,13., -2., 4.,
     9., 8., 1., -2., 4.,
     9., 1.,-7.,  5.,-1.,
     2.,-6., 6.,  5., 1.,
     4., 5., 0., -2., 2.] )

load('svd.js')
let u,w,vt= a.svd()
print(w)

[35.327043465311384, 1.2982256062667619e-15,
 19.999999999999996, 19.595917942265423, 0.0]

// the correct answer is (the order may vary)

print([Math.sqrt(1248.),20.,Math.sqrt(384.),0.,0.])

[35.327043465311391, 20.0, 19.595917942265423, 0.0, 0.0]

*/

// Returns U, W, V, where (this= U * W * VT)

Matrix.prototype.pinv = function(precision)
{
 let prec= precision || 1.e-15   // assumes double prec
 let [u, w, v] = this.svd()
 let tolerance = prec * Math.max(this.rows,this.cols) * Math.max.apply(null,w)
 
 wp = new Matrix(w.length,w.length)
 wp.zero()

 for (let i=0;i<w.length;i++)
  wp.set(i,i,Math.abs(w[i]) >= tolerance ? 1/w[i] : 0)
 
 return v.times(wp).times(u.transpose())
}

/**
Calculates the thin SVD from G. H. Golub and C. Reinsch, Numer. Math. 14, 403-420 (1970)
Returns (U,Q,V) where Q is a list of eigenvalues
U . Q . V* = this
Recover the original as U
*/
Matrix.prototype.svd = function(precision)
{
//this = U E V*
//this function returns U, E as a vector, V
//Compute the thin SVD from G. H. Golub and C. Reinsch, Numer. Math. 14, 403-420 (1970)
  let prec= precision || 1.e-15 //Math.pow(2,-52) // assumes double prec
  let tolerance= 1.e-64/prec
  if (1.0+prec <= 1.0) throw "Need a bigger precision" 
  if (!(tolerance > 0.0))  throw "Need a bigger tolerance" 
  let itmax= 50
  let c=0
  let i=0
  let j=0
  let k=0
  let l=0
  
  let u= this.copy()
  let m= this.rows
  
  let n= this.cols
  
  if (m < n) throw "Need more rows than columns"
  
  let e = new Array(n)
  let q = new Array(n)
  for (i=0; i<n; i++) e[i] = q[i] = 0.0
  let v = new Matrix(n,n)
  v.zero()
  
  function pythag(a,b)
  {
    a = Math.abs(a)
    b = Math.abs(b)
    if (a > b)
      return a*Math.sqrt(1.0+(b*b/a/a))
    else if (b == 0.0) 
      return a
    return b*Math.sqrt(1.0+(a*a/b/b))
  }

  //Householder's reduction to bidiagonal form

  let f= 0.0
  let g= 0.0  
  let h= 0.0
  let x= 0.0
  let y= 0.0
  let z= 0.0
  let s= 0.0
  
  for (i=0; i < n; i++)
  { 
    e[i]= g
    s= 0.0
    l= i+1
    for (j=i; j < m; j++) 
      s += (u.get(j,i)*u.get(j,i))
    if (s <= tolerance)
      g= 0.0
    else
    { 
      f= u.get(i,i)
      g= Math.sqrt(s)
      if (f >= 0.0) g= -g
      h= f*g-s
      u.set(i,i, f-g)
      for (j=l; j < n; j++)
      {
        s= 0.0
        for (k=i; k < m; k++) 
          s += u.get(k,i)*u.get(k,j)
        f= s/h
        for (k=i; k < m; k++) 
          u.set(k,j, u.get(k,j) + f*u.get(k,i))
      }
    }
    q[i]= g
    s= 0.0
    for (j=l; j < n; j++) 
      s= s + u.get(i,j)*u.get(i,j)
    if (s <= tolerance)
      g= 0.0
    else
    { 
      f= u.get(i,i+1)
      g= Math.sqrt(s)
      if (f >= 0.0) g= -g
      h= f*g - s
      u.set(i,i+1, f-g)
      for (j=l; j < n; j++) e[j]= u.get(i,j)/h
      for (j=l; j < m; j++)
      { 
        s=0.0
        for (k=l; k < n; k++) 
          s += (u.get(j,k)*u.get(i,k))
        for (k=l; k < n; k++) 
          u.set(j,k, u.get(j,k)+(s*e[k]))
      } 
    }
    y= Math.abs(q[i])+Math.abs(e[i])
    if (y>x) 
      x=y
  }
  
  // accumulation of right hand gtransformations
  for (i=n-1; i != -1; i+= -1)
  { 
    if (g != 0.0)
    {
      h= g*u.get(i,i+1)
      for (j=l; j < n; j++) 
        v.set(j,i, u.get(i,j)/h)
      for (j=l; j < n; j++)
      { 
        s=0.0
        for (k=l; k < n; k++) 
          s += (u.get(i,k)*v.get(k,j))
        for (k=l; k < n; k++) 
          v.set(k,j,v.get(k,j)+ (s*v.get(k,i)))
      } 
    }
    for (j=l; j < n; j++)
    {
      v.set(i,j, 0.0)
      v.set(j,i, 0.0)
    }
    v.set(i,i, 1.0)
    g= e[i]
    l= i
  }
  
  // accumulation of left hand transformations
  for (i=n-1; i != -1; i+= -1)
  { 
    l= i+1
    g= q[i]
    for (j=l; j < n; j++) 
      u.set(i,j, 0.0)
    if (g != 0.0)
    {
      h= u.get(i,i)*g
      for (j=l; j < n; j++)
      {
        s=0.0
        for (k=l; k < m; k++) s += (u.get(k,i)*u.get(k,j))
        f= s/h
        for (k=i; k < m; k++) u.set(k,j,u.get(k,j) + (f*u.get(k,i)))
      }
      for (j=i; j < m; j++) u.set(j,i, u.get(j,i)/g)
    }
    else
      for (j=i; j < m; j++) u.set(j,i, 0.0)
    u.set(i,i,u.get(i,i) + 1.0)
  }
  
  // diagonalization of the bidiagonal form
  prec= prec*x
  for (k=n-1; k != -1; k+= -1)
  {
    for (let iteration=0; iteration < itmax; iteration++)
    { // test f splitting
      let test_convergence = false
      for (l=k; l != -1; l+= -1)
      { 
        if (Math.abs(e[l]) <= prec)
        { test_convergence= true
          break 
        }
        if (Math.abs(q[l-1]) <= prec)
          break 
      }
      if (!test_convergence)
      { // cancellation of e[l] if l>0
        c= 0.0
        s= 1.0
        let l1= l-1
        for (i =l; i<k+1; i++)
        { 
          f= s*e[i]
          e[i]= c*e[i]
          if (Math.abs(f) <= prec)
            break
          g= q[i]
          h= pythag(f,g)
          q[i]= h
          c= g/h
          s= -f/h
          for (j=0; j < m; j++)
          { 
            y= u.get(j,l1)
            z= u.get(j,i)
            u.set(j,l1, y*c+(z*s))
            u.set(j,i, -y*s+(z*c))
          } 
        } 
      }
      // test f convergence
      z= q[k]
      if (l== k)
      { //convergence
        if (z<0.0)
        { //q[k] is made non-negative
          q[k]= -z
          for (j=0; j < n; j++)
            v.set(j,k, -v.get(j,k))
        }
        break  //break out of iteration loop and move on to next k value
      }
      if (iteration >= itmax-1)
        throw 'Error: no convergence.'
      // shift from bottom 2x2 minor
      x= q[l]
      y= q[k-1]
      g= e[k-1]
      h= e[k]
      f= ((y-z)*(y+z)+(g-h)*(g+h))/(2.0*h*y)
      g= pythag(f,1.0)
      if (f < 0.0)
        f= ((x-z)*(x+z)+h*(y/(f-g)-h))/x
      else
        f= ((x-z)*(x+z)+h*(y/(f+g)-h))/x
      // next QR transformation
      c= 1.0
      s= 1.0
      for (i=l+1; i< k+1; i++)
      { 
        g= e[i]
        y= q[i]
        h= s*g
        g= c*g
        z= pythag(f,h)
        e[i-1]= z
        c= f/z
        s= h/z
        f= x*c+g*s
        g= -x*s+g*c
        h= y*s
        y= y*c
        for (j=0; j < n; j++)
        { 
          x= v.get(j,i-1)
          z= v.get(j,i)
          v.set(j,i-1, x*c+z*s)
          v.set(j,i, -x*s+z*c)
        }
        z= pythag(f,h)
        q[i-1]= z
        c= f/z
        s= h/z
        f= c*g+s*y
        x= -s*g+c*y
        for (j=0; j < m; j++)
        {
          y= u.get(j,i-1)
          z= u.get(j,i)
          u.set(j,i-1, y*c+z*s)
          u.set(j,i, -y*s+z*c)
        }
      }
      e[l]= 0.0
      e[k]= f
      q[k]= x
    } 
  }
    
  //vt= transpose(v)
  //return (u,q,vt)
  for (i=0;i<q.length; i++) 
    if (q[i] < prec) q[i] = 0
    
  //sort eigenvalues  
  for (i=0; i< n; i++)
  {  
  //writeln(q)
   for (j=i-1; j >= 0; j--)
   {
    if (q[j] < q[i])
    {
  //  writeln(i,'-',j)
     c = q[j]
     q[j] = q[i]
     q[i] = c
     u.swapCols(i,j)
     v.swapCols(i,j)
     i = j     
    }
   }  
  }
  
  return [u,q,v]
}

Matrix.testsvd = function()
{
  a= new Matrix(8,5,[
      22.,10., 2.,  3., 7.,
      14., 7.,10.,  0., 8.,
      -1.,13.,-1.,-11., 3.,
      -3.,-2.,13., -2., 4.,
       9., 8., 1., -2., 4.,
       9., 1.,-7.,  5.,-1.,
       2.,-6., 6.,  5., 1.,
       4., 5., 0., -2., 2.] )

  let [u,w,v]= a.svd()
  writeln(u.times(Matrix.diagonal(w)).times(v.transpose()).round())
}

Matrix.testpinv = function()
{
a= new Matrix(8,5,[
    22.,10., 2.,  3., 7.,
    14., 7.,10.,  0., 8.,
    -1.,13.,-1.,-11., 3.,
    -3.,-2.,13., -2., 4.,
     9., 8., 1., -2., 4.,
     9., 1.,-7.,  5.,-1.,
     2.,-6., 6.,  5., 1.,
     4., 5., 0., -2., 2.] )

let [u,w,v]= a.svd()

writeln(w)
writeln([Math.sqrt(1248.),20.,Math.sqrt(384.),0.,0.])
writeln()

b = a.pinv()
writeln(b)
writeln(a.times(b))
//print(u,w,vt)
}

/** Given a square matrix S and vector Y, returns X such that S . X = Y */
Matrix.solve = function(S,Y)
{
  //adapted from http://home.att.net/~srschmitt/
  //eliminate
  let i, j, k;
  N = S.rows;
  if (N != S.cols) throw "S must be a square matrix";
  if (N != Y.rows) throw "Y must be a " + N + "x1 matrix";
 
  let A = new Matrix(S.rows, S.cols + Y.cols)
 
  for (i = 0; i < S.rows; i++)
  {
    A.put(i, S.cols, Y.at(i,0))
    for (j = 0; j < S.cols; j++)
      A.put(i, j, S.at(i,j))    
  }

  for (i = 0; i < N; i++)
  {
    // find row with maximum in column i
    let max_row = i;
    for (j = i; j < N; j++)
    {
     if (Math.abs(A.at(j,i)) > Math.abs(A.at(max_row,i)))
       max_row = j;
    }

    // swap max row with row i of [A:y]
    for (k = i; k < N + 1; k++)
    {
     let tmp       = A.at(i,k);
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
  let X = new Matrix(Y.rows, Y.cols); //cols should be 1
  X.zero();

  for (j = N - 1; j >= 0; j--)
  {
    let sum = 0.0;
    for (k = j+1; k < N; k++)
      sum += A.at(j,k)*X.at(k,0);

    X.put(j, 0, (A.at(j,N) - sum)/A.at(j,j));
  }
return X;
}

Matrix.fit = function(order,data)
{
 //data = [ [x1, y1], [x2, y2], [x3,y3] ]
 let N = data.length
 if (!order) throw "Matrix.fit missing parameter: order"
 let s = new Matrix(order+1,order+1)
 s.zero()
 
 let x = new Array(2*order +1); //[0,0,0,0,0]
 for (let i=0; i< x.length; i++)
  x[i] = 0;
 
 let xy = new Array(order+1); //[0,0,0]
 for (let i=0; i < xy.length; i++)
  xy[i] = 0;
 
 for (let d in data)
 {
  let a = data[d][0]
  let b = 1
  let c = data[d][1]
  for (let j=0; j< x.length; j++)
  {
   x[j] += b
   b = b * a
  }
  for (let j=0; j< xy.length; j++)
  {
   xy[order-j] += c
   c = c * a
  }   
 }

 let y = new Matrix(xy.length,1,xy)
 
 for (let i=0; i<s.rows; i++)
 for (let j=0; j<s.cols; j++)
 {
  s.put(i, j, x[x.length - 1 - i - j ])
 }
 
 let ret = Matrix.solve(s,y).data
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
 
  writeln()
  writeln('Inverse')
  s = new Matrix(3,3,[1,5,6,3,2,4,6,2,3])
  writeln(s)
  writeln(s.inverse())
  writeln(s.times(s.inverse()).round())
  writeln()
 
  s = new Matrix(3,3,[1,5,6,3,2,4,6,2,3])
  writeln(s)
  writeln(s.inverse())
  writeln(s.times(s.inverse()).round())
}
  
