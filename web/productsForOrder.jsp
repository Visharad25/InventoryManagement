<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    if (request.getSession().getAttribute("validUser") == null) {
        String errorMsg = "You are not logged in. Please login first!!";
        request.setAttribute("ErrorMsg", errorMsg);
        request.getRequestDispatcher("loginPage.jsp").forward(request, response);
    }
%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
        <meta name="generator" content="Hugo 0.88.1">
        <title>Orders</title>
        <!-- Bootstrap core CSS -->
        <link href="./css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
        <meta name="theme-color" content="#7952b3">


        <style>
            .bd-placeholder-img {
                font-size: 1.125rem;
                text-anchor: middle;
                -webkit-user-select: none;
                -moz-user-select: none;
                user-select: none;
            }

            @media (min-width: 768px) {
                .bd-placeholder-img-lg {
                    font-size: 3.5rem;
                }
            }
        </style>
        
        <!--adding javascript here -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>


        <script>
            function showCartValue()
            {
                $('#result').html('<c:out value="${sessionScope.Cart.size()}" />');
            }

            function addProductToCart(pid)
            {

                var qty = document.getElementById("Quantity_" + pid).value;
                $.ajax({
                    url: 'AddProductToCart',
                    method: 'POST',
                    data: {productId: pid, quantity: qty},
                    success: function (resultText) {
                        $('#result').html(resultText);
                    },
                    error: function (jqXHR, exception) {
                        console.log('Error occured!!');
                    }
                });
            }

            function getProductPrice()
            {
                var prodId = document.getElementById("productList").value;

                $.ajax({
                    url: 'FindProductPrice',
                    method: 'POST',
                    data: {prodId: prodId},
                    success: function (resultText) {
                        $('#productPrice').html(resultText);
                    },
                    error: function (jqXHR, exception) {
                        console.log('Error occured!!');
                    }
                });
            }

            function getProductAvailability()
            {
                var prodId = document.getElementById("productDetails").value;

                $.ajax({
                    url: 'FindProductAvailability',
                    method: 'POST',
                    data: {prodId: prodId},
                    success: function (resultText) {
                        $('#productAvailability').html(resultText);
                    },
                    error: function (jqXHR, exception) {
                        console.log('Error occured!!');
                    }
                });
            }

        </script>


        <!-- Custom styles for this template -->
        <link href="./css/dashboard.css" rel="stylesheet">
    </head>
    <body>

        <header class="navbar navbar-dark sticky-top bg-dark flex-md-nowrap p-0 shadow">
            <a class="navbar-brand col-md-3 col-lg-2 me-0 px-3" href="http://www.exavalu.com">
                Exavalu<br>
                Welcome <c:out value='${sessionScope.validUser.getFirstName()}'/>
            </a>
            <button class="navbar-toggler position-absolute d-md-none collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#sidebarMenu" aria-controls="sidebarMenu" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <input class="form-control form-control-dark w-100" type="text" placeholder="Search" aria-label="Search">
            <div class="navbar-nav">
                <div class="nav-item text-nowrap">
                    <a class="nav-link px-3" href="Logout">Sign out</a>
                </div>
            </div>
        </header>
        <div class="container-fluid">
            <div class="row">
                <nav id="sidebarMenu" class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse">
                    <div class="position-sticky pt-3">
                        <ul class="nav flex-column">
                            <li class="nav-item">
                                <a class="nav-link active" href="Dashboard">
                                    <span data-feather="home"></span>
                                    Dashboard
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="ShowOrders">
                                    <span data-feather="file"></span>
                                    Orders
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="ShowProducts">
                                    <span data-feather="shopping-cart"></span>
                                    Products
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="ShowCustomers">
                                    <span data-feather="users"></span>
                                    Customers
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">
                                    <span data-feather="bar-chart-2"></span>
                                    Reports
                                </a>
                            </li>
                        </ul>

                        <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted">
                            <span>Saved reports</span>
                            <a class="link-secondary" href="#" aria-label="Add a new report">
                                <span data-feather="plus-circle"></span>
                            </a>
                        </h6>
                        <ul class="nav flex-column mb-2">
                            <li class="nav-item">
                                <a class="nav-link" href="#">
                                    <span data-feather="file-text"></span>
                                    Current month
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">
                                    <span data-feather="file-text"></span>
                                    Last quarter
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">
                                    <span data-feather="file-text"></span>
                                    Social engagement
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">
                                    <span data-feather="file-text"></span>
                                    Year-end sale
                                </a>
                            </li>
                        </ul>
                    </div>
                </nav>

                <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">

                    <h2>Place Order</h2>
                    <form action="SaveProduct" method="post">
                        <div class="table-responsive">
                            <table class="table table-striped table-sm">
                                <thead>
                                    <tr>
                                        <th scope="col">Product Name</th> 
                                        <td>
                                            <select onchange="getProductAvailability()" id="productDetails" name="productId">
                                                    <c:forEach items="${requestScope.products}" var="product">
                                                        <option value="<c:out value="${product.getProductId()}"></c:out>">
                                                            <c:out value="${product.getProductName()}"></c:out>
                                                            </option>
                                                    </c:forEach>
                                                </select>
                                        </td>
                                        </tr>
                                        <tr>
                                            <th scope="col">Product Make</th>
                                            <td>
                                                <select onchange="getProductPrice()" id="productList" name="productId">
                                                    <c:forEach items="${requestScope.products}" var="product">
                                                        <option value="<c:out value="${product.getProductId()}"></c:out>">
                                                            <c:out value="${product.getProductMake()}"></c:out>
                                                            </option>
                                                    </c:forEach>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th scope="col">Product Price</th>
                                            <td>
                                                <textArea id="productPrice" rows="1" cols="25" style="align-content:center; border:1px outset #000000;" readonly></textarea>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th scope="col">Availlability</th>
                                            <td>
                                                
                                                <textArea id="productAvailability" rows="1" cols="25" style="align-content:center; border:1px outset #000000;" readonly></textarea>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th scope="col">Order Quantity</th>
                                            <td>
                                                <c:forEach items="${requestScope.products}" var="product">
                                                <c:out value="${product.getAvailability()}"></c:out>
                                                <input type="number" min="1" max="<c:out value="${product.getAvailability()}"></c:out>" onkeyup="if (this.value < 0) {this.value = this.value * -1}" id='Quantity_<c:out value="${product.getProductId()}"/>' value="">
                                                </c:forEach>
                                            </td>
                                        </tr>                                        
                                    <tr>
                                        <td>
                                            <input type="submit" name="Submit">
                                        </td>
                                        <td>
                                            <input type="button" name="Cancel" value="Cancel">
                                        </td>
                                    </tr>
                                </thead>                            
                            </table>
                        </div>
                    </form>
                </main>
            </div>
        </div> 
    </body>
</html>
