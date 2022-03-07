<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="constants.ForwardConst" %>
<%@ page import="constants.AttributeConst" %>

<c:set var="actRep" value="${ForwardConst.ACT_REP.getValue()}" />
<c:set var="commIdx" value="${ForwardConst.CMD_INDEX.getValue()}" />
<c:set var="commEdt" value="${ForwardConst.CMD_EDIT.getValue()}" />
<c:set var="commCmt" value="${ForwardConst.CMD_COMMENT.getValue()}" />

<c:import url="/WEB-INF/views/layout/app.jsp">
    <c:param name="content">

        <h2>日報 詳細ページ</h2>

        <table>
            <tbody>
                <tr>
                    <th>氏名</th>
                    <td><c:out value="${report.employee.name}" /></td>
                </tr>
                <tr>
                    <th>日付</th>
                    <fmt:parseDate value="${report.reportDate}" pattern="yyyy-MM-dd" var="reportDay" type="date" />
                    <td><fmt:formatDate value='${reportDay}' pattern='yyyy-MM-dd' /></td>
                </tr>
                <tr>
                    <th>内容</th>
                    <td><pre><c:out value="${report.content}" /></pre></td>
                </tr>
                <tr>
                    <th>登録日時</th>
                    <fmt:parseDate value="${report.createdAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="createDay" type="date" />
                    <td><fmt:formatDate value="${createDay}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                </tr>
                <tr>
                    <th>更新日時</th>
                    <fmt:parseDate value="${report.updatedAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="updateDay" type="date" />
                    <td><fmt:formatDate value="${updateDay}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                </tr>
                 </tbody>
        </table>


       <h3>コメント</h3>
         <div>
               <c:if test="${sessionScope.login_employee != null}">
                  <c:choose>
                      <c:when  test="${sessionScope.login_employee.adminFlag == AttributeConst.ROLE_ADMIN.getIntegerValue() and sessionScope.login_employee.id != report.employee.id}">
                            <form method="POST" action="<c:url value='?action=${actRep}&command=${commCmt}&id=${report.id}' />">

                                <div class="confirm_flag">
                                   <c:if test="${report.confirm_flag == 0}">
                                        <span><input type="radio" name="${AttributeConst.REP_CONFIRM_FLAG.getValue()}" value="0" checked>保留</span>
                                        <span style="margin-left:1em;"><input type="radio" name="${AttributeConst.REP_CONFIRM_FLAG.getValue()}" value="1">承認</span>
                                   </c:if>
                                   <c:if test="${report.confirm_flag == 1}">
                                        <span><input type="radio" name="${AttributeConst.REP_CONFIRM_FLAG.getValue()}" value="0">保留</span>
                                        <span style="margin-left:1em;"><input type="radio" name="${AttributeConst.REP_CONFIRM_FLAG.getValue()}" value="1" checked>承認</span>
                                   </c:if>
                                   <c:if test="${report.confirm_flag == null}">
                                        <span><input type="radio" name="${AttributeConst.REP_CONFIRM_FLAG.getValue()}" value="0" checked>保留</span>
                                        <span style="margin-left:1em;"><input type="radio" name="${AttributeConst.REP_CONFIRM_FLAG.getValue()}" value="1">承認</span>
                                   </c:if>
                                </div>

                                   <textarea name="${AttributeConst.REP_COMMENT.getValue()}" rows="10" cols="50">${report.comment}</textarea>
                                    <br>
                                    <button type="submit">登録</button>
                             </form>
                     </c:when>
                     <c:otherwise>

                            <div class="confirm_flag">
                                  <c:if test="${report.confirm_flag == 0}">
                                       <p>保留中</p>
                                  </c:if>
                                  <c:if test="${report.confirm_flag == 1}">
                                        <p>承認済</p>
                                  </c:if>
                                  <c:if test="${report.confirm_flag == null}">
                                        <p>未確認</p>
                                  </c:if>
                            </div>
                            <div id="comment">${report.comment}</div>

                      </c:otherwise>
                      </c:choose>
               </c:if>
        </div>



        <c:if test="${sessionScope.login_employee.id == report.employee.id}">
            <p>
                <a href="<c:url value='?action=${actRep}&command=${commEdt}&id=${report.id}' />">この日報を編集する</a>
            </p>
        </c:if>

        <p>
            <a href="<c:url value='?action=${actRep}&command=${commIdx}' />">一覧に戻る</a>
        </p>
    </c:param>
</c:import>