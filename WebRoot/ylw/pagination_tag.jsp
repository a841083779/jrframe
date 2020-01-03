<%@ page language="java"  pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x" %>
<%@ taglib uri="http://21-sun.com/pager-taglib" prefix="pg"%> 
<html>
  <head><title></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="Content-Language" content="zh-cn">
	</head>
  
  <body>
  <br><br>
    <table border=0 cellpadding=0 cellspacing=0 align=center>
    <tr align=center valign=top>
        

        <pg:first >
            <td>
                <c:choose>
                    <c:when test="${pageUrl!=null }">
                        <A HREF="${pageUrl}&sort_no=${param.sort_no}&myid=${param.myid}&catalog_no=${param.catalog_no}"><b>第一页</b></A>
                    </c:when>
                    <c:otherwise>
                        <b>第一页</b>
                    </c:otherwise>
                </c:choose>
                &nbsp;
            </td>
        </pg:first>
        <pg:prev export="pageUrl" ifnull="${true }">
            <td>
                <c:choose>
                    <c:when test="${pageUrl!=null }">
                        <A HREF="${pageUrl}&sort_no=${param.sort_no}&myid=${param.myid}&catalog_no=${param.catalog_no}"><b>上一页</b></A>
                    </c:when>
                    <c:otherwise>
                        <b>上一页</b>
                    </c:otherwise>
                </c:choose>&nbsp;
            </td>
        </pg:prev>
        <pg:pages>
            <td>
                <c:choose>
                    <c:when test="${pageNumber == curNumber}">
                        <b>${pageNumber}</b>&nbsp;
                    </c:when>
                    <c:otherwise>
                        [<A HREF="${pageUrl}&sort_no=${param.sort_no}&myid=${param.myid}&catalog_no=${param.catalog_no}">${pageNumber}</A>]&nbsp;
                    </c:otherwise>
                </c:choose>
            </td>
        </pg:pages>
        <pg:next export="pageUrl" ifnull="${true }">
            <td>
                <c:choose>
                    <c:when test="${pageUrl!=null }">
                        <A HREF="${pageUrl}&sort_no=${param.sort_no}&myid=${param.myid}&catalog_no=${param.catalog_no}"><b>下一页</b></A>
                    </c:when>
                    <c:otherwise>
                        <b>下一页</b>
                    </c:otherwise>
                </c:choose>
                &nbsp;
            </td>
        </pg:next>
        <pg:last >
            <td>
                <c:choose>
                    <c:when test="${pageUrl!=null }">
                        <A HREF="${pageUrl}&sort_no=${param.sort_no}&myid=${param.myid}&catalog_no=${param.catalog_no}"><b>最后页</b></A>
                    </c:when>
                    <c:otherwise>
                        <b>最后页</b>
                    </c:otherwise>
                </c:choose>
                &nbsp;
            </td>
        </pg:last>
    </tr>
</table>
  </body>
</html>