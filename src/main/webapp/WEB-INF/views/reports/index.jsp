<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="constants.ForwardConst" %>

<c:set var="actRep" value="${ForwardConst.ACT_REP.getValue()}" />
<c:set var="commIdx" value="${ForwardConst.CMD_INDEX.getValue()}" />
<c:set var="commShow" value="${ForwardConst.CMD_SHOW.getValue()}" />
<c:set var="commNew" value="${ForwardConst.CMD_NEW.getValue()}" />

<c:import url="/WEB-INF/views/layout/app.jsp">
    <c:param name="content">
        <c:if test="${flush != null}">
            <div id="flush_success">
                <c:out value="${flush}"></c:out>
            </div>
        </c:if>
        <h2>日報　一覧</h2>

        <c:if test="${reports_count != 0}">
            <table id="report_list">
                <tbody>
                    <tr>
                        <th class="report_name">氏名</th>
                        <th class="report_date">日付</th>
                        <th class="report_title">タイトル</th>
                        <th class="report_action">操作</th>
                    </tr>
                    <c:forEach var="report" items="${reports}" varStatus="status">
                        <fmt:parseDate value="${report.reportDate}" pattern="yyyy-MM-dd" var="reportDay" type="date" />

                        <c:if test="${report.confirm_flag == 0}">
                            <tr class="row${status.count % 2} bold">
                        </c:if>
                        <c:if test="${report.confirm_flag == 1}">
                            <tr class="row${status.count % 2}">
                        </c:if>
                            <td class="report_name"><c:out value="${report.employee.name}" /></td>
                            <td class="report_date"><fmt:formatDate value='${reportDay}' pattern='yyyy-MM-dd' /></td>
                            <td class="report_title">${report.title}</td>
                            <td class="report_action"><a href="<c:url value='?action=${actRep}&command=${commShow}&id=${report.id}' />">詳細を見る</a></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>

        <c:if test="${reports_count == 0}">
        <p class="report_none">記事がありません</p>
        </c:if>

        <p><a href="<c:url value='?action=${actRep}&command=${commNew}' />">新規日報の登録</a></p>

        <div id="pagination">
            <c:forEach var="i" begin="1" end="${((reports_count - 1) / maxRow) + 1}" step="1">
                <c:choose>
                    <c:when test="${i == page}">
                        <c:out value="${i}" />&nbsp;
                    </c:when>
                    <c:otherwise>
                        <a href="<c:url value='?action=${actRep}&command=${commIdx}&page=${i}' />"><c:out value="${i}" /></a>&nbsp;
                    </c:otherwise>
                </c:choose>
            </c:forEach>
           <br /> （全 ${reports_count} 件）
        </div>

    </c:param>
</c:import>