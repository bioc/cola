<!-- Generated by pkgdown: do not edit by hand -->
<!DOCTYPE html>
<html lang="en">
  <head>
  <meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Get parameters — get_param-ConsensusPartition-method • cola</title>


<!-- jquery -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
<!-- Bootstrap -->

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha256-916EbMg70RQy9LHiGkXzG8hSg9EdNy97GazNG/aiY1w=" crossorigin="anonymous" />

<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha256-U5ZEeKfGNOja007MMD3YBI0A3OSZOQbeG6z2f2Y0hu8=" crossorigin="anonymous"></script>

<!-- Font Awesome icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.7.1/css/all.min.css" integrity="sha256-nAmazAk6vS34Xqo0BSrTb+abbtFlgsFK7NKSi6o7Y78=" crossorigin="anonymous" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.7.1/css/v4-shims.min.css" integrity="sha256-6qHlizsOWFskGlwVOKuns+D1nB6ssZrHQrNj1wGplHc=" crossorigin="anonymous" />

<!-- clipboard.js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/clipboard.js/2.0.4/clipboard.min.js" integrity="sha256-FiZwavyI2V6+EXO1U+xzLG3IKldpiTFf3153ea9zikQ=" crossorigin="anonymous"></script>

<!-- headroom.js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/headroom/0.9.4/headroom.min.js" integrity="sha256-DJFC1kqIhelURkuza0AvYal5RxMtpzLjFhsnVIeuk+U=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/headroom/0.9.4/jQuery.headroom.min.js" integrity="sha256-ZX/yNShbjqsohH1k95liqY9Gd8uOiE1S4vZc+9KQ1K4=" crossorigin="anonymous"></script>

<!-- pkgdown -->
<link href="../pkgdown.css" rel="stylesheet">
<script src="../pkgdown.js"></script>




<meta property="og:title" content="Get parameters — get_param-ConsensusPartition-method" />
<meta property="og:description" content="Get parameters" />
<meta name="twitter:card" content="summary" />




<!-- mathjax -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.5/MathJax.js" integrity="sha256-nvJJv9wWKEm88qvoQl9ekL2J+k/RWIsaSScxxlsrv8k=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.5/config/TeX-AMS-MML_HTMLorMML.js" integrity="sha256-84DKXVJXs0/F8OTMzX4UR909+jtl4G7SPypPavF+GfA=" crossorigin="anonymous"></script>

<!--[if lt IE 9]>
<script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->



  </head>

  <body>
    <div class="container template-reference-topic">
      <header>
      <div class="navbar navbar-default navbar-fixed-top" role="navigation">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <span class="navbar-brand">
        <a class="navbar-link" href="../index.html">cola</a>
        <span class="version label label-default" data-toggle="tooltip" data-placement="bottom" title="Released version">1.1.2</span>
      </span>
    </div>

    <div id="navbar" class="navbar-collapse collapse">
      <ul class="nav navbar-nav">
        <li>
  <a href="../index.html">
    <span class="fas fa fas fa-home fa-lg"></span>
     
  </a>
</li>
<li>
  <a href="../articles/cola.html">Get started</a>
</li>
<li>
  <a href="../reference/index.html">Reference</a>
</li>
<li class="dropdown">
  <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
    Articles
     
    <span class="caret"></span>
  </a>
  <ul class="dropdown-menu" role="menu">
    <li>
      <a href="../articles/a_quick_start.html">UNKNOWN TITLE</a>
    </li>
  </ul>
</li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li>
  <a href="https://github.com/jokergoo/cola">
    <span class="fab fa fab fa-github fa-lg"></span>
     
  </a>
</li>
      </ul>
      
    </div><!--/.nav-collapse -->
  </div><!--/.container -->
</div><!--/.navbar -->

      

      </header>

<div class="row">
  <div class="col-md-9 contents">
    <div class="page-header">
    <h1>Get parameters</h1>
    
    <div class="hidden name"><code>get_param-ConsensusPartition-method.rd</code></div>
    </div>

    <div class="ref-description">
    <p>Get parameters</p>
    </div>

    <pre class="usage"><span class='co'># S4 method for ConsensusPartition</span>
<span class='fu'><a href='get_param-ConsensusPartition-method.rd.html'>get_param</a></span>(<span class='no'>object</span>, <span class='kw'>k</span> <span class='kw'>=</span> <span class='no'>object</span>@<span class='kw'>k</span>, <span class='kw'>unique</span> <span class='kw'>=</span> <span class='fl'>TRUE</span>)</pre>

    <h2 class="hasAnchor" id="arguments"><a class="anchor" href="#arguments"></a>Arguments</h2>
    <table class="ref-arguments">
    <colgroup><col class="name" /><col class="desc" /></colgroup>
    <tr>
      <th>object</th>
      <td><p>A <code><a href='ConsensusPartition-class.rd.html'>ConsensusPartition-class</a></code> object.</p></td>
    </tr>
    <tr>
      <th>k</th>
      <td><p>Number of partitions.</p></td>
    </tr>
    <tr>
      <th>unique</th>
      <td><p>Whether apply <code><a href='https://rdrr.io/r/base/unique.html'>unique</a></code> to rows of the returned data frame.</p></td>
    </tr>
    </table>

    <h2 class="hasAnchor" id="details"><a class="anchor" href="#details"></a>Details</h2>

    <p>It is mainly used internally.</p>
    <h2 class="hasAnchor" id="value"><a class="anchor" href="#value"></a>Value</h2>

    <p>A data frame of parameters corresponding to the current k. In the data frame, each row corresponds
to a partition run.</p>

    <h2 class="hasAnchor" id="examples"><a class="anchor" href="#examples"></a>Examples</h2>
    <pre class="examples"><div class='input'><span class='fu'><a href='https://rdrr.io/r/utils/data.html'>data</a></span>(<span class='no'>cola_rl</span>)
<span class='no'>obj</span> <span class='kw'>=</span> <span class='no'>cola_rl</span>[<span class='st'>"sd"</span>, <span class='st'>"kmeans"</span>]
<span class='fu'><a href='get_param-ConsensusPartition-method.rd.html'>get_param</a></span>(<span class='no'>obj</span>)</div><div class='output co'>#&gt;    top_n k n_row n_col
#&gt; 1     20 2    16    60
#&gt; 2     30 2    24    60
#&gt; 3     40 2    32    60
#&gt; 4     20 3    16    60
#&gt; 5     30 3    24    60
#&gt; 6     40 3    32    60
#&gt; 7     20 4    16    60
#&gt; 8     30 4    24    60
#&gt; 9     40 4    32    60
#&gt; 10    20 5    16    60
#&gt; 11    30 5    24    60
#&gt; 12    40 5    32    60
#&gt; 13    20 6    16    60
#&gt; 14    30 6    24    60
#&gt; 15    40 6    32    60</div><div class='input'><span class='fu'><a href='get_param-ConsensusPartition-method.rd.html'>get_param</a></span>(<span class='no'>obj</span>, <span class='kw'>k</span> <span class='kw'>=</span> <span class='fl'>2</span>)</div><div class='output co'>#&gt;   top_n k n_row n_col
#&gt; 1    20 2    16    60
#&gt; 2    30 2    24    60
#&gt; 3    40 2    32    60</div><div class='input'><span class='fu'><a href='get_param-ConsensusPartition-method.rd.html'>get_param</a></span>(<span class='no'>obj</span>, <span class='kw'>unique</span> <span class='kw'>=</span> <span class='fl'>FALSE</span>)</div><div class='output co'>#&gt;     top_n k n_row n_col
#&gt; 1      20 2    16    60
#&gt; 2      20 2    16    60
#&gt; 3      20 2    16    60
#&gt; 4      20 2    16    60
#&gt; 5      20 2    16    60
#&gt; 6      20 2    16    60
#&gt; 7      20 2    16    60
#&gt; 8      20 2    16    60
#&gt; 9      20 2    16    60
#&gt; 10     20 2    16    60
#&gt; 11     20 2    16    60
#&gt; 12     20 2    16    60
#&gt; 13     20 2    16    60
#&gt; 14     20 2    16    60
#&gt; 15     20 2    16    60
#&gt; 16     20 2    16    60
#&gt; 17     20 2    16    60
#&gt; 18     20 2    16    60
#&gt; 19     20 2    16    60
#&gt; 20     20 2    16    60
#&gt; 21     20 2    16    60
#&gt; 22     20 2    16    60
#&gt; 23     20 2    16    60
#&gt; 24     20 2    16    60
#&gt; 25     20 2    16    60
#&gt; 26     20 2    16    60
#&gt; 27     20 2    16    60
#&gt; 28     20 2    16    60
#&gt; 29     20 2    16    60
#&gt; 30     20 2    16    60
#&gt; 31     20 2    16    60
#&gt; 32     20 2    16    60
#&gt; 33     20 2    16    60
#&gt; 34     20 2    16    60
#&gt; 35     20 2    16    60
#&gt; 36     20 2    16    60
#&gt; 37     20 2    16    60
#&gt; 38     20 2    16    60
#&gt; 39     20 2    16    60
#&gt; 40     20 2    16    60
#&gt; 41     20 2    16    60
#&gt; 42     20 2    16    60
#&gt; 43     20 2    16    60
#&gt; 44     20 2    16    60
#&gt; 45     20 2    16    60
#&gt; 46     20 2    16    60
#&gt; 47     20 2    16    60
#&gt; 48     20 2    16    60
#&gt; 49     20 2    16    60
#&gt; 50     20 2    16    60
#&gt; 51     30 2    24    60
#&gt; 52     30 2    24    60
#&gt; 53     30 2    24    60
#&gt; 54     30 2    24    60
#&gt; 55     30 2    24    60
#&gt; 56     30 2    24    60
#&gt; 57     30 2    24    60
#&gt; 58     30 2    24    60
#&gt; 59     30 2    24    60
#&gt; 60     30 2    24    60
#&gt; 61     30 2    24    60
#&gt; 62     30 2    24    60
#&gt; 63     30 2    24    60
#&gt; 64     30 2    24    60
#&gt; 65     30 2    24    60
#&gt; 66     30 2    24    60
#&gt; 67     30 2    24    60
#&gt; 68     30 2    24    60
#&gt; 69     30 2    24    60
#&gt; 70     30 2    24    60
#&gt; 71     30 2    24    60
#&gt; 72     30 2    24    60
#&gt; 73     30 2    24    60
#&gt; 74     30 2    24    60
#&gt; 75     30 2    24    60
#&gt; 76     30 2    24    60
#&gt; 77     30 2    24    60
#&gt; 78     30 2    24    60
#&gt; 79     30 2    24    60
#&gt; 80     30 2    24    60
#&gt; 81     30 2    24    60
#&gt; 82     30 2    24    60
#&gt; 83     30 2    24    60
#&gt; 84     30 2    24    60
#&gt; 85     30 2    24    60
#&gt; 86     30 2    24    60
#&gt; 87     30 2    24    60
#&gt; 88     30 2    24    60
#&gt; 89     30 2    24    60
#&gt; 90     30 2    24    60
#&gt; 91     30 2    24    60
#&gt; 92     30 2    24    60
#&gt; 93     30 2    24    60
#&gt; 94     30 2    24    60
#&gt; 95     30 2    24    60
#&gt; 96     30 2    24    60
#&gt; 97     30 2    24    60
#&gt; 98     30 2    24    60
#&gt; 99     30 2    24    60
#&gt; 100    30 2    24    60
#&gt; 101    40 2    32    60
#&gt; 102    40 2    32    60
#&gt; 103    40 2    32    60
#&gt; 104    40 2    32    60
#&gt; 105    40 2    32    60
#&gt; 106    40 2    32    60
#&gt; 107    40 2    32    60
#&gt; 108    40 2    32    60
#&gt; 109    40 2    32    60
#&gt; 110    40 2    32    60
#&gt; 111    40 2    32    60
#&gt; 112    40 2    32    60
#&gt; 113    40 2    32    60
#&gt; 114    40 2    32    60
#&gt; 115    40 2    32    60
#&gt; 116    40 2    32    60
#&gt; 117    40 2    32    60
#&gt; 118    40 2    32    60
#&gt; 119    40 2    32    60
#&gt; 120    40 2    32    60
#&gt; 121    40 2    32    60
#&gt; 122    40 2    32    60
#&gt; 123    40 2    32    60
#&gt; 124    40 2    32    60
#&gt; 125    40 2    32    60
#&gt; 126    40 2    32    60
#&gt; 127    40 2    32    60
#&gt; 128    40 2    32    60
#&gt; 129    40 2    32    60
#&gt; 130    40 2    32    60
#&gt; 131    40 2    32    60
#&gt; 132    40 2    32    60
#&gt; 133    40 2    32    60
#&gt; 134    40 2    32    60
#&gt; 135    40 2    32    60
#&gt; 136    40 2    32    60
#&gt; 137    40 2    32    60
#&gt; 138    40 2    32    60
#&gt; 139    40 2    32    60
#&gt; 140    40 2    32    60
#&gt; 141    40 2    32    60
#&gt; 142    40 2    32    60
#&gt; 143    40 2    32    60
#&gt; 144    40 2    32    60
#&gt; 145    40 2    32    60
#&gt; 146    40 2    32    60
#&gt; 147    40 2    32    60
#&gt; 148    40 2    32    60
#&gt; 149    40 2    32    60
#&gt; 150    40 2    32    60
#&gt; 151    20 3    16    60
#&gt; 152    20 3    16    60
#&gt; 153    20 3    16    60
#&gt; 154    20 3    16    60
#&gt; 155    20 3    16    60
#&gt; 156    20 3    16    60
#&gt; 157    20 3    16    60
#&gt; 158    20 3    16    60
#&gt; 159    20 3    16    60
#&gt; 160    20 3    16    60
#&gt; 161    20 3    16    60
#&gt; 162    20 3    16    60
#&gt; 163    20 3    16    60
#&gt; 164    20 3    16    60
#&gt; 165    20 3    16    60
#&gt; 166    20 3    16    60
#&gt; 167    20 3    16    60
#&gt; 168    20 3    16    60
#&gt; 169    20 3    16    60
#&gt; 170    20 3    16    60
#&gt; 171    20 3    16    60
#&gt; 172    20 3    16    60
#&gt; 173    20 3    16    60
#&gt; 174    20 3    16    60
#&gt; 175    20 3    16    60
#&gt; 176    20 3    16    60
#&gt; 177    20 3    16    60
#&gt; 178    20 3    16    60
#&gt; 179    20 3    16    60
#&gt; 180    20 3    16    60
#&gt; 181    20 3    16    60
#&gt; 182    20 3    16    60
#&gt; 183    20 3    16    60
#&gt; 184    20 3    16    60
#&gt; 185    20 3    16    60
#&gt; 186    20 3    16    60
#&gt; 187    20 3    16    60
#&gt; 188    20 3    16    60
#&gt; 189    20 3    16    60
#&gt; 190    20 3    16    60
#&gt; 191    20 3    16    60
#&gt; 192    20 3    16    60
#&gt; 193    20 3    16    60
#&gt; 194    20 3    16    60
#&gt; 195    20 3    16    60
#&gt; 196    20 3    16    60
#&gt; 197    20 3    16    60
#&gt; 198    20 3    16    60
#&gt; 199    20 3    16    60
#&gt; 200    20 3    16    60
#&gt; 201    30 3    24    60
#&gt; 202    30 3    24    60
#&gt; 203    30 3    24    60
#&gt; 204    30 3    24    60
#&gt; 205    30 3    24    60
#&gt; 206    30 3    24    60
#&gt; 207    30 3    24    60
#&gt; 208    30 3    24    60
#&gt; 209    30 3    24    60
#&gt; 210    30 3    24    60
#&gt; 211    30 3    24    60
#&gt; 212    30 3    24    60
#&gt; 213    30 3    24    60
#&gt; 214    30 3    24    60
#&gt; 215    30 3    24    60
#&gt; 216    30 3    24    60
#&gt; 217    30 3    24    60
#&gt; 218    30 3    24    60
#&gt; 219    30 3    24    60
#&gt; 220    30 3    24    60
#&gt; 221    30 3    24    60
#&gt; 222    30 3    24    60
#&gt; 223    30 3    24    60
#&gt; 224    30 3    24    60
#&gt; 225    30 3    24    60
#&gt; 226    30 3    24    60
#&gt; 227    30 3    24    60
#&gt; 228    30 3    24    60
#&gt; 229    30 3    24    60
#&gt; 230    30 3    24    60
#&gt; 231    30 3    24    60
#&gt; 232    30 3    24    60
#&gt; 233    30 3    24    60
#&gt; 234    30 3    24    60
#&gt; 235    30 3    24    60
#&gt; 236    30 3    24    60
#&gt; 237    30 3    24    60
#&gt; 238    30 3    24    60
#&gt; 239    30 3    24    60
#&gt; 240    30 3    24    60
#&gt; 241    30 3    24    60
#&gt; 242    30 3    24    60
#&gt; 243    30 3    24    60
#&gt; 244    30 3    24    60
#&gt; 245    30 3    24    60
#&gt; 246    30 3    24    60
#&gt; 247    30 3    24    60
#&gt; 248    30 3    24    60
#&gt; 249    30 3    24    60
#&gt; 250    30 3    24    60
#&gt; 251    40 3    32    60
#&gt; 252    40 3    32    60
#&gt; 253    40 3    32    60
#&gt; 254    40 3    32    60
#&gt; 255    40 3    32    60
#&gt; 256    40 3    32    60
#&gt; 257    40 3    32    60
#&gt; 258    40 3    32    60
#&gt; 259    40 3    32    60
#&gt; 260    40 3    32    60
#&gt; 261    40 3    32    60
#&gt; 262    40 3    32    60
#&gt; 263    40 3    32    60
#&gt; 264    40 3    32    60
#&gt; 265    40 3    32    60
#&gt; 266    40 3    32    60
#&gt; 267    40 3    32    60
#&gt; 268    40 3    32    60
#&gt; 269    40 3    32    60
#&gt; 270    40 3    32    60
#&gt; 271    40 3    32    60
#&gt; 272    40 3    32    60
#&gt; 273    40 3    32    60
#&gt; 274    40 3    32    60
#&gt; 275    40 3    32    60
#&gt; 276    40 3    32    60
#&gt; 277    40 3    32    60
#&gt; 278    40 3    32    60
#&gt; 279    40 3    32    60
#&gt; 280    40 3    32    60
#&gt; 281    40 3    32    60
#&gt; 282    40 3    32    60
#&gt; 283    40 3    32    60
#&gt; 284    40 3    32    60
#&gt; 285    40 3    32    60
#&gt; 286    40 3    32    60
#&gt; 287    40 3    32    60
#&gt; 288    40 3    32    60
#&gt; 289    40 3    32    60
#&gt; 290    40 3    32    60
#&gt; 291    40 3    32    60
#&gt; 292    40 3    32    60
#&gt; 293    40 3    32    60
#&gt; 294    40 3    32    60
#&gt; 295    40 3    32    60
#&gt; 296    40 3    32    60
#&gt; 297    40 3    32    60
#&gt; 298    40 3    32    60
#&gt; 299    40 3    32    60
#&gt; 300    40 3    32    60
#&gt; 301    20 4    16    60
#&gt; 302    20 4    16    60
#&gt; 303    20 4    16    60
#&gt; 304    20 4    16    60
#&gt; 305    20 4    16    60
#&gt; 306    20 4    16    60
#&gt; 307    20 4    16    60
#&gt; 308    20 4    16    60
#&gt; 309    20 4    16    60
#&gt; 310    20 4    16    60
#&gt; 311    20 4    16    60
#&gt; 312    20 4    16    60
#&gt; 313    20 4    16    60
#&gt; 314    20 4    16    60
#&gt; 315    20 4    16    60
#&gt; 316    20 4    16    60
#&gt; 317    20 4    16    60
#&gt; 318    20 4    16    60
#&gt; 319    20 4    16    60
#&gt; 320    20 4    16    60
#&gt; 321    20 4    16    60
#&gt; 322    20 4    16    60
#&gt; 323    20 4    16    60
#&gt; 324    20 4    16    60
#&gt; 325    20 4    16    60
#&gt; 326    20 4    16    60
#&gt; 327    20 4    16    60
#&gt; 328    20 4    16    60
#&gt; 329    20 4    16    60
#&gt; 330    20 4    16    60
#&gt; 331    20 4    16    60
#&gt; 332    20 4    16    60
#&gt; 333    20 4    16    60
#&gt; 334    20 4    16    60
#&gt; 335    20 4    16    60
#&gt; 336    20 4    16    60
#&gt; 337    20 4    16    60
#&gt; 338    20 4    16    60
#&gt; 339    20 4    16    60
#&gt; 340    20 4    16    60
#&gt; 341    20 4    16    60
#&gt; 342    20 4    16    60
#&gt; 343    20 4    16    60
#&gt; 344    20 4    16    60
#&gt; 345    20 4    16    60
#&gt; 346    20 4    16    60
#&gt; 347    20 4    16    60
#&gt; 348    20 4    16    60
#&gt; 349    20 4    16    60
#&gt; 350    20 4    16    60
#&gt; 351    30 4    24    60
#&gt; 352    30 4    24    60
#&gt; 353    30 4    24    60
#&gt; 354    30 4    24    60
#&gt; 355    30 4    24    60
#&gt; 356    30 4    24    60
#&gt; 357    30 4    24    60
#&gt; 358    30 4    24    60
#&gt; 359    30 4    24    60
#&gt; 360    30 4    24    60
#&gt; 361    30 4    24    60
#&gt; 362    30 4    24    60
#&gt; 363    30 4    24    60
#&gt; 364    30 4    24    60
#&gt; 365    30 4    24    60
#&gt; 366    30 4    24    60
#&gt; 367    30 4    24    60
#&gt; 368    30 4    24    60
#&gt; 369    30 4    24    60
#&gt; 370    30 4    24    60
#&gt; 371    30 4    24    60
#&gt; 372    30 4    24    60
#&gt; 373    30 4    24    60
#&gt; 374    30 4    24    60
#&gt; 375    30 4    24    60
#&gt; 376    30 4    24    60
#&gt; 377    30 4    24    60
#&gt; 378    30 4    24    60
#&gt; 379    30 4    24    60
#&gt; 380    30 4    24    60
#&gt; 381    30 4    24    60
#&gt; 382    30 4    24    60
#&gt; 383    30 4    24    60
#&gt; 384    30 4    24    60
#&gt; 385    30 4    24    60
#&gt; 386    30 4    24    60
#&gt; 387    30 4    24    60
#&gt; 388    30 4    24    60
#&gt; 389    30 4    24    60
#&gt; 390    30 4    24    60
#&gt; 391    30 4    24    60
#&gt; 392    30 4    24    60
#&gt; 393    30 4    24    60
#&gt; 394    30 4    24    60
#&gt; 395    30 4    24    60
#&gt; 396    30 4    24    60
#&gt; 397    30 4    24    60
#&gt; 398    30 4    24    60
#&gt; 399    30 4    24    60
#&gt; 400    30 4    24    60
#&gt; 401    40 4    32    60
#&gt; 402    40 4    32    60
#&gt; 403    40 4    32    60
#&gt; 404    40 4    32    60
#&gt; 405    40 4    32    60
#&gt; 406    40 4    32    60
#&gt; 407    40 4    32    60
#&gt; 408    40 4    32    60
#&gt; 409    40 4    32    60
#&gt; 410    40 4    32    60
#&gt; 411    40 4    32    60
#&gt; 412    40 4    32    60
#&gt; 413    40 4    32    60
#&gt; 414    40 4    32    60
#&gt; 415    40 4    32    60
#&gt; 416    40 4    32    60
#&gt; 417    40 4    32    60
#&gt; 418    40 4    32    60
#&gt; 419    40 4    32    60
#&gt; 420    40 4    32    60
#&gt; 421    40 4    32    60
#&gt; 422    40 4    32    60
#&gt; 423    40 4    32    60
#&gt; 424    40 4    32    60
#&gt; 425    40 4    32    60
#&gt; 426    40 4    32    60
#&gt; 427    40 4    32    60
#&gt; 428    40 4    32    60
#&gt; 429    40 4    32    60
#&gt; 430    40 4    32    60
#&gt; 431    40 4    32    60
#&gt; 432    40 4    32    60
#&gt; 433    40 4    32    60
#&gt; 434    40 4    32    60
#&gt; 435    40 4    32    60
#&gt; 436    40 4    32    60
#&gt; 437    40 4    32    60
#&gt; 438    40 4    32    60
#&gt; 439    40 4    32    60
#&gt; 440    40 4    32    60
#&gt; 441    40 4    32    60
#&gt; 442    40 4    32    60
#&gt; 443    40 4    32    60
#&gt; 444    40 4    32    60
#&gt; 445    40 4    32    60
#&gt; 446    40 4    32    60
#&gt; 447    40 4    32    60
#&gt; 448    40 4    32    60
#&gt; 449    40 4    32    60
#&gt; 450    40 4    32    60
#&gt; 451    20 5    16    60
#&gt; 452    20 5    16    60
#&gt; 453    20 5    16    60
#&gt; 454    20 5    16    60
#&gt; 455    20 5    16    60
#&gt; 456    20 5    16    60
#&gt; 457    20 5    16    60
#&gt; 458    20 5    16    60
#&gt; 459    20 5    16    60
#&gt; 460    20 5    16    60
#&gt; 461    20 5    16    60
#&gt; 462    20 5    16    60
#&gt; 463    20 5    16    60
#&gt; 464    20 5    16    60
#&gt; 465    20 5    16    60
#&gt; 466    20 5    16    60
#&gt; 467    20 5    16    60
#&gt; 468    20 5    16    60
#&gt; 469    20 5    16    60
#&gt; 470    20 5    16    60
#&gt; 471    20 5    16    60
#&gt; 472    20 5    16    60
#&gt; 473    20 5    16    60
#&gt; 474    20 5    16    60
#&gt; 475    20 5    16    60
#&gt; 476    20 5    16    60
#&gt; 477    20 5    16    60
#&gt; 478    20 5    16    60
#&gt; 479    20 5    16    60
#&gt; 480    20 5    16    60
#&gt; 481    20 5    16    60
#&gt; 482    20 5    16    60
#&gt; 483    20 5    16    60
#&gt; 484    20 5    16    60
#&gt; 485    20 5    16    60
#&gt; 486    20 5    16    60
#&gt; 487    20 5    16    60
#&gt; 488    20 5    16    60
#&gt; 489    20 5    16    60
#&gt; 490    20 5    16    60
#&gt; 491    20 5    16    60
#&gt; 492    20 5    16    60
#&gt; 493    20 5    16    60
#&gt; 494    20 5    16    60
#&gt; 495    20 5    16    60
#&gt; 496    20 5    16    60
#&gt; 497    20 5    16    60
#&gt; 498    20 5    16    60
#&gt; 499    20 5    16    60
#&gt; 500    20 5    16    60
#&gt; 501    30 5    24    60
#&gt; 502    30 5    24    60
#&gt; 503    30 5    24    60
#&gt; 504    30 5    24    60
#&gt; 505    30 5    24    60
#&gt; 506    30 5    24    60
#&gt; 507    30 5    24    60
#&gt; 508    30 5    24    60
#&gt; 509    30 5    24    60
#&gt; 510    30 5    24    60
#&gt; 511    30 5    24    60
#&gt; 512    30 5    24    60
#&gt; 513    30 5    24    60
#&gt; 514    30 5    24    60
#&gt; 515    30 5    24    60
#&gt; 516    30 5    24    60
#&gt; 517    30 5    24    60
#&gt; 518    30 5    24    60
#&gt; 519    30 5    24    60
#&gt; 520    30 5    24    60
#&gt; 521    30 5    24    60
#&gt; 522    30 5    24    60
#&gt; 523    30 5    24    60
#&gt; 524    30 5    24    60
#&gt; 525    30 5    24    60
#&gt; 526    30 5    24    60
#&gt; 527    30 5    24    60
#&gt; 528    30 5    24    60
#&gt; 529    30 5    24    60
#&gt; 530    30 5    24    60
#&gt; 531    30 5    24    60
#&gt; 532    30 5    24    60
#&gt; 533    30 5    24    60
#&gt; 534    30 5    24    60
#&gt; 535    30 5    24    60
#&gt; 536    30 5    24    60
#&gt; 537    30 5    24    60
#&gt; 538    30 5    24    60
#&gt; 539    30 5    24    60
#&gt; 540    30 5    24    60
#&gt; 541    30 5    24    60
#&gt; 542    30 5    24    60
#&gt; 543    30 5    24    60
#&gt; 544    30 5    24    60
#&gt; 545    30 5    24    60
#&gt; 546    30 5    24    60
#&gt; 547    30 5    24    60
#&gt; 548    30 5    24    60
#&gt; 549    30 5    24    60
#&gt; 550    30 5    24    60
#&gt; 551    40 5    32    60
#&gt; 552    40 5    32    60
#&gt; 553    40 5    32    60
#&gt; 554    40 5    32    60
#&gt; 555    40 5    32    60
#&gt; 556    40 5    32    60
#&gt; 557    40 5    32    60
#&gt; 558    40 5    32    60
#&gt; 559    40 5    32    60
#&gt; 560    40 5    32    60
#&gt; 561    40 5    32    60
#&gt; 562    40 5    32    60
#&gt; 563    40 5    32    60
#&gt; 564    40 5    32    60
#&gt; 565    40 5    32    60
#&gt; 566    40 5    32    60
#&gt; 567    40 5    32    60
#&gt; 568    40 5    32    60
#&gt; 569    40 5    32    60
#&gt; 570    40 5    32    60
#&gt; 571    40 5    32    60
#&gt; 572    40 5    32    60
#&gt; 573    40 5    32    60
#&gt; 574    40 5    32    60
#&gt; 575    40 5    32    60
#&gt; 576    40 5    32    60
#&gt; 577    40 5    32    60
#&gt; 578    40 5    32    60
#&gt; 579    40 5    32    60
#&gt; 580    40 5    32    60
#&gt; 581    40 5    32    60
#&gt; 582    40 5    32    60
#&gt; 583    40 5    32    60
#&gt; 584    40 5    32    60
#&gt; 585    40 5    32    60
#&gt; 586    40 5    32    60
#&gt; 587    40 5    32    60
#&gt; 588    40 5    32    60
#&gt; 589    40 5    32    60
#&gt; 590    40 5    32    60
#&gt; 591    40 5    32    60
#&gt; 592    40 5    32    60
#&gt; 593    40 5    32    60
#&gt; 594    40 5    32    60
#&gt; 595    40 5    32    60
#&gt; 596    40 5    32    60
#&gt; 597    40 5    32    60
#&gt; 598    40 5    32    60
#&gt; 599    40 5    32    60
#&gt; 600    40 5    32    60
#&gt; 601    20 6    16    60
#&gt; 602    20 6    16    60
#&gt; 603    20 6    16    60
#&gt; 604    20 6    16    60
#&gt; 605    20 6    16    60
#&gt; 606    20 6    16    60
#&gt; 607    20 6    16    60
#&gt; 608    20 6    16    60
#&gt; 609    20 6    16    60
#&gt; 610    20 6    16    60
#&gt; 611    20 6    16    60
#&gt; 612    20 6    16    60
#&gt; 613    20 6    16    60
#&gt; 614    20 6    16    60
#&gt; 615    20 6    16    60
#&gt; 616    20 6    16    60
#&gt; 617    20 6    16    60
#&gt; 618    20 6    16    60
#&gt; 619    20 6    16    60
#&gt; 620    20 6    16    60
#&gt; 621    20 6    16    60
#&gt; 622    20 6    16    60
#&gt; 623    20 6    16    60
#&gt; 624    20 6    16    60
#&gt; 625    20 6    16    60
#&gt; 626    20 6    16    60
#&gt; 627    20 6    16    60
#&gt; 628    20 6    16    60
#&gt; 629    20 6    16    60
#&gt; 630    20 6    16    60
#&gt; 631    20 6    16    60
#&gt; 632    20 6    16    60
#&gt; 633    20 6    16    60
#&gt; 634    20 6    16    60
#&gt; 635    20 6    16    60
#&gt; 636    20 6    16    60
#&gt; 637    20 6    16    60
#&gt; 638    20 6    16    60
#&gt; 639    20 6    16    60
#&gt; 640    20 6    16    60
#&gt; 641    20 6    16    60
#&gt; 642    20 6    16    60
#&gt; 643    20 6    16    60
#&gt; 644    20 6    16    60
#&gt; 645    20 6    16    60
#&gt; 646    20 6    16    60
#&gt; 647    20 6    16    60
#&gt; 648    20 6    16    60
#&gt; 649    20 6    16    60
#&gt; 650    20 6    16    60
#&gt; 651    30 6    24    60
#&gt; 652    30 6    24    60
#&gt; 653    30 6    24    60
#&gt; 654    30 6    24    60
#&gt; 655    30 6    24    60
#&gt; 656    30 6    24    60
#&gt; 657    30 6    24    60
#&gt; 658    30 6    24    60
#&gt; 659    30 6    24    60
#&gt; 660    30 6    24    60
#&gt; 661    30 6    24    60
#&gt; 662    30 6    24    60
#&gt; 663    30 6    24    60
#&gt; 664    30 6    24    60
#&gt; 665    30 6    24    60
#&gt; 666    30 6    24    60
#&gt; 667    30 6    24    60
#&gt; 668    30 6    24    60
#&gt; 669    30 6    24    60
#&gt; 670    30 6    24    60
#&gt; 671    30 6    24    60
#&gt; 672    30 6    24    60
#&gt; 673    30 6    24    60
#&gt; 674    30 6    24    60
#&gt; 675    30 6    24    60
#&gt; 676    30 6    24    60
#&gt; 677    30 6    24    60
#&gt; 678    30 6    24    60
#&gt; 679    30 6    24    60
#&gt; 680    30 6    24    60
#&gt; 681    30 6    24    60
#&gt; 682    30 6    24    60
#&gt; 683    30 6    24    60
#&gt; 684    30 6    24    60
#&gt; 685    30 6    24    60
#&gt; 686    30 6    24    60
#&gt; 687    30 6    24    60
#&gt; 688    30 6    24    60
#&gt; 689    30 6    24    60
#&gt; 690    30 6    24    60
#&gt; 691    30 6    24    60
#&gt; 692    30 6    24    60
#&gt; 693    30 6    24    60
#&gt; 694    30 6    24    60
#&gt; 695    30 6    24    60
#&gt; 696    30 6    24    60
#&gt; 697    30 6    24    60
#&gt; 698    30 6    24    60
#&gt; 699    30 6    24    60
#&gt; 700    30 6    24    60
#&gt; 701    40 6    32    60
#&gt; 702    40 6    32    60
#&gt; 703    40 6    32    60
#&gt; 704    40 6    32    60
#&gt; 705    40 6    32    60
#&gt; 706    40 6    32    60
#&gt; 707    40 6    32    60
#&gt; 708    40 6    32    60
#&gt; 709    40 6    32    60
#&gt; 710    40 6    32    60
#&gt; 711    40 6    32    60
#&gt; 712    40 6    32    60
#&gt; 713    40 6    32    60
#&gt; 714    40 6    32    60
#&gt; 715    40 6    32    60
#&gt; 716    40 6    32    60
#&gt; 717    40 6    32    60
#&gt; 718    40 6    32    60
#&gt; 719    40 6    32    60
#&gt; 720    40 6    32    60
#&gt; 721    40 6    32    60
#&gt; 722    40 6    32    60
#&gt; 723    40 6    32    60
#&gt; 724    40 6    32    60
#&gt; 725    40 6    32    60
#&gt; 726    40 6    32    60
#&gt; 727    40 6    32    60
#&gt; 728    40 6    32    60
#&gt; 729    40 6    32    60
#&gt; 730    40 6    32    60
#&gt; 731    40 6    32    60
#&gt; 732    40 6    32    60
#&gt; 733    40 6    32    60
#&gt; 734    40 6    32    60
#&gt; 735    40 6    32    60
#&gt; 736    40 6    32    60
#&gt; 737    40 6    32    60
#&gt; 738    40 6    32    60
#&gt; 739    40 6    32    60
#&gt; 740    40 6    32    60
#&gt; 741    40 6    32    60
#&gt; 742    40 6    32    60
#&gt; 743    40 6    32    60
#&gt; 744    40 6    32    60
#&gt; 745    40 6    32    60
#&gt; 746    40 6    32    60
#&gt; 747    40 6    32    60
#&gt; 748    40 6    32    60
#&gt; 749    40 6    32    60
#&gt; 750    40 6    32    60</div></pre>
  </div>
  <div class="col-md-3 hidden-xs hidden-sm" id="sidebar">
    <h2>Contents</h2>
    <ul class="nav nav-pills nav-stacked">
      <li><a href="#arguments">Arguments</a></li>
      <li><a href="#details">Details</a></li>
      <li><a href="#value">Value</a></li>
      <li><a href="#examples">Examples</a></li>
    </ul>

    <h2>Author</h2>
    <p>Zuguang Gu &lt;z.gu@dkfz.de&gt;</p>
  </div>
</div>


      <footer>
      <div class="copyright">
  <p>Developed by Zuguang Gu.</p>
</div>

<div class="pkgdown">
  <p>Site built with <a href="https://pkgdown.r-lib.org/">pkgdown</a> 1.4.1.</p>
</div>

      </footer>
   </div>

  


  </body>
</html>

