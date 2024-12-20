<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.7.1/css/all.css">
    <style>
        body {
            margin: 0px;
            padding: 0px;
            box-sizing: border-box !important;
            overflow-x: hidden;
            font-size: 14px;
        }
        header {
            background: #007fff;
            padding: 10px;
            text-align: center;
            color: white;
            display: flex;
            margin: 0px;
        }

        header > div {
            width: 40%;
        }

        header > div:first-child {
            width: 30%;
            text-align: left;
        }

        header > div:last-child {
            width: 30%;
            text-align: right;
        }

        header > div > .button-bars {
            border: none;
            background: none;
            color: white;
            padding: 0px;
            margin: 5px 15px;
        }
        header > div > .button-bars > i {
            font-size: 22px;
        }

        .list-menu-nav {
            border-right: 1px solid #e5e5e5;
            margin: 0px;
            padding: 0px 0px 10px 0px;
        }

        .list-menu-nav > a {
            display: block;
            padding: 5px 0px 5px 15px;
            text-decoration: none;
            color: black;
            margin: 0px;
        }

        .list-menu-nav > a:hover {
            background: #e5e5e5;
        }

        footer {
            background: #007fff;
            color: white;
            text-align: center;
            padding: 10px 20px;
        }
    </style>
</head>
<body>
<header>
        <div>
            <button class="button-bars" id="button-bars" onclick="bars_menu()"><i class="fas fa-bars"></i></button>
        </div>
        <div>
            <h5>DU AN TOT NGHIEP</h5>
        </div>
        <div>
            <a class="btn btn-sm btn-light">Dang Nhap</a>
            <a class="btn btn-sm btn-danger">Dang Ky</a>
        </div>
</header>
<div class="row ">
    <div class="col-3" id="col-3">
        <div class="list-menu-nav">
            <a href="/sell-counter">Ban Hang</a>
            <a href="/chat-lieu/hien-thi">Chat Lieu</a>
            <a href="/danh-gia/hien-thi">Danh Gia</a>
            <a href="/danh-muc/hien-thi">Danh Muc</a>
            <a href="/dia-chi/hien-thi">Dia Chi</a>
            <a href="/hinh-anh/hien-thi">Hinh Anh</a>
            <a href="/hoa-don/hien-thi">Hoa Don</a>
            <a href="/hoa-don-chi-tiet/hien-thi">Hoa Don Chi Tiet</a>
            <a href="/khach-hang/hien-thi">Khach Hang</a>
            <a href="/khuyen-mai/hien-thi">Khuyen Mai</a>
            <a href="/kich-thuoc/hien-thi">Kich Thuoc</a>
            <a href="/ma-giam-gia/hien-thi">Ma Giam Gia</a>
            <a href="/mau-sac/hien-thi">Mau Sac</a>
            <a href="/nhan-vien/hien-thi">Nhan Vien</a>
            <a href="/phuong-thuc-thanh-toan/hien-thi">Phuong Thuc Thanh Toan</a>
            <a href="/san-pham/hien-thi">San Pham</a>
            <a href="/san-pham-chi-tiet/hien-thi">San Pham Chi Tiet</a>
            <a href="/thuong-hieu/hien-thi">Thuong Hieu</a>
            <a href="/xuat-su/hien-thi">Xuat Xu</a>
        </div>
    </div>
    <div class="col-9" id="col-9">
        <div class="pt-3 ps-2 pe-3 pb-3">
            <img src="https://thuythu.vn/wp-content/uploads/2021/06/website-ban-quan-ao-asos.png" style="width: 100%">
            <%--    dgddg    --%>

        </div>
    </div>
    <div class="col-md-12">
        <footer>THANH NAM-FONT_END</footer>
    </div>
</div>
<script>
    function bars_menu() {
        let classMenu = document.getElementById("button-bars").innerHTML;
        if(classMenu == '<i class="fas fa-bars"></i>') {
            document.getElementById("button-bars").innerHTML = ' <i class="fas fa-bars active"></i>';
            document.getElementById("col-3").style.display = "none";
            document.getElementById("col-9").classList.add("col-12");
            document.getElementById("col-9").classList.remove("col-9");
        } else {
            document.getElementById("button-bars").innerHTML = '<i class="fas fa-bars"></i>';
            document.getElementById("col-3").style.display = "block";
            document.getElementById("col-9").classList.remove("col-12");
            document.getElementById("col-9").classList.add("col-9");
        }
    }
</script>
</body>
</html>