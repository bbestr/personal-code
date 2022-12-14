
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../foreinclude/foreHander1.jsp"%>


<div class="breadcrumb-area pt-15 pb-15">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <!--=======  breadcrumb container  =======-->

                <div class="breadcrumb-container">
                    <nav>
                        <ul>
                            <li class="parent-page"><a href="/fore/foreIndex">Home</a></li>
                            <li>orders</li>
                        </ul>
                    </nav>
                </div>

                <!--=======  End of breadcrumb container  =======-->
            </div>
        </div>
    </div>
</div>

<style>
    .order_goods_list li{float:left; height:80px;line-height:80px;}
    .order_goods_list .col01{width:20%}
    .order_goods_list .col01 img{width:60px;height:60px;border:1px solid #ddd;margin:10px auto;}
    .order_goods_list .col02{width:24%;text-align:center;}
    .order_goods_list .col02 em{color:#999;margin-left:10px}
    .order_goods_list .col03{width:10%}
    .order_goods_list .col04{width:20%}

    .order_list_th{width:1107.2px;border:1px solid #ddd;background-color:#f7f7f7;margin:20px auto 0;}
    .order_list_th li{float:left;height:30px;line-height:30px}
    .order_list_th .col01{width:35%;margin-left:20px}
    .order_list_th .col02{width:20%}
</style>
<!--=== My Account page content ===-->

<div class="page-section mb-50">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="row">
                    <!-- My Account Tab Content Start -->
                    <div class="col-lg-12 col-12">
                        <div class="tab-content" id="myaccountContent">
                            <!-- Single Tab Content Start -->
                            <div class="tab-pane fade show active"  role="tabpanel">
                                <div class="myaccount-content">
                                    <h3>Orders</h3>
                                    <c:forEach items="${os}" var="order" varStatus="vs">
                                    <ul style="float:left" class="order_list_th">
                                        <li class="col01">${vs.count}&nbsp;&nbsp;&nbsp;&nbsp;????????????${order.code},?????????</li>
                                    </ul>
                                    <div class="myaccount-table table-responsive text-center">
                                        <table class="table table-bordered" width='100%' border='0' cellspacing='0' cellpadding='0'  style='table-layout: fixed'>
                                            <tbody>
                                            <tr>
                                                <td width="55%">
                                                    <c:forEach items="${order.orderItems}" var="oi">
                                                    <ul class="order_goods_list">
                                                        <li class="col01"><a href="foreDetailUI?id=${oi.product.id}"><img src="${pageContext.request.contextPath}/${oi.product.imageurl}" width="50px" height="50px"></a></li>
                                                        <li class="col02"><a href="foreDetailUI?id=${oi.product.id}">${oi.product.name},${oi.product.price}</a></li>
                                                        <li class="col03">${oi.number}</li>
                                                        <li class="col04">$${oi.product.price*oi.number}</li>
                                                        <li class="col04"><a href="javascript:;" onclick="pingjia(${oi.product.id});">??????</a></li>
                                                    </ul>
                                                    </c:forEach>
                                                </td>
                                                <td width="15%">${order.total}???</td>
                                                <td width="15%" >
                                                    <div class="hover-icons">
                                                        <a href="#" id="addressMsg" onclick="showAddressMsg('${order.address}');" title="${order.address}">
                                                            <img src="${pageContext.request.contextPath}/images/address.png" width="30px" height="30px">
                                                        </a>
                                                    </div>
                                                </td>
                                                <td width="15%">
                                                    <c:if test="${order.status==1}">?????????</c:if>
                                                    <c:if test="${order.status==2}">?????????</c:if>
                                                </td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    </c:forEach>
                                 </div>
                             </div>
                    <!-- Single Tab Content End -->
                    </div>
            </div>
        <!-- My Account Tab Content End -->
        </div>

                </div>
                </div>
        </div>
        </div>
<!-- ????????????Modal??? -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"  id="myModal" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <!--???????????????-->
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    ??
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    ???????????????
                </h4>
            </div>
            <!--?????????????????????(from??????)-->
            <div class="modal-body">
                <!--??????-->
                <div class="form-group">
                    <label for="contents" class="col-sm-4 control-label">????????????</label>
                    <div class="col-sm-12">
                        <textarea class="form-control" name="content" id="contents" placeholder="??????????????????..." required="required"></textarea>
                    </div>
                </div>
                <!--????????????-->
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <button type="button" class="btn btn-default" data-dismiss="modal">??????</button>
                        <button type="button" class="btn btn-default"  id="modalpinglun">??????</button>
                    </div>
                </div>
                <%--</form>--%>
            </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/jquery/2.0.0/jquery.min.js"></script>
<script>
   function showAddressMsg(msg) {
       alert(msg)
   }
   var pid;
   $(function () {
       //??????????????????
       $("#modalpinglun").click(function () {
           var  content = $("#contents").val();
           //??????
           if($("#contents").val().length==0){
               alert("??????????????????")
               return false;
           }
           else {
               $.get(
                   "cstPinglun",
                   {"pid": pid, "content": content},
                   function (result) {
                       if (result = "success") {
                           alert("????????????")
                           $("#contents").val("");
                           $('#myModal').modal('hide');
                       }
                   }
               );
           }
           //get??????
       });

   });
   //???????????? ??????????????????
   function pingjia(productid) {
       pid=productid;
       $('#myModal').modal('show');
       //????????????
   }

</script>
<!--====  End of My Account page content  ====-->
<%@ include file="../../foreinclude/foreFooter.jsp"%>