<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="uts.booking.Booking"%>
<%@page import="java.util.ArrayList"%>
<%@page import="uts.booking.Bookings"%>
<%@page import="uts.student.Students"%>
<%@page import="uts.tutor.Tutors"%>
<%@page import="uts.tutor.Tutor"%>
<%@page import="uts.student.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="animation.js"></script>
        <link rel="stylesheet" type="text/css" href="mystyle.css">
        <title>Booking Page</title>
    </head>
    <body onload="startTime()">
        <div >
            <span class="float">UTSTutor</span>  <span class="time" id="time" ></span>
        </div>
        <% String studentPath = application.getRealPath("WEB-INF/students.xml");%>
        <jsp:useBean id="studentApp" class="uts.student.StudentApplication" scope="application">
            <jsp:setProperty name="studentApp" property="filePath" value="<%=studentPath%>"/>
        </jsp:useBean>
        <% String tutorPath = application.getRealPath("WEB-INF/tutors.xml");%>
        <jsp:useBean id="tutorApp" class="uts.tutor.TutorApplication" scope="application">
            <jsp:setProperty name="tutorApp" property="filePath" value="<%=tutorPath%>"/>
        </jsp:useBean>
        <% String bookingsPath = application.getRealPath("WEB-INF/bookings.xml");%>
        <jsp:useBean id="bookingApp" class="uts.booking.BookingApplication" scope="application">
            <jsp:setProperty name="bookingApp" property="filePath" value="<%=bookingsPath%>"/>
        </jsp:useBean>
        <%Bookings bookings = bookingApp.getBookings();%>
        <%Tutors tutors = tutorApp.getTutors();%>
        <%Students students = studentApp.getStudents();%>
        <%
            Student student = (Student) session.getAttribute("student");
            Tutor tutor = (Tutor) session.getAttribute("tutor");
            String log = "";
            String type = "";
            if (student != null) {
                log = " &lt " + student.getName() + " &gt";
                type = student.getType();
            } else if (tutor != null) {
                log = " &lt " + tutor.getName() + " &gt";
                type = tutor.getType();
            } else {
                log = " &lt " + " Unkonwn User " + " &gt";
            }
        %>
        <h2 class="header"><%=type%> Booking Menu</h2>
        <table class="main_table" >
            <tr ><td align="right" class="log" >You are logged in as  <%=log%></td></tr>
            <tr><td align="right"><u><a  class="link" href="bookings.jsp">View All</a></u> &emsp;<u><a  class="link" href="main.jsp">Main</a></u> &emsp;<u><a  class="link" href="edit_user.jsp">Account</a></u> &emsp; <u><a class="link" href="logout.jsp">Logout</a></u>&emsp; </td></tr>
        </table>
        <%
            String bookingMsg = (String) session.getAttribute("bookingMsg");  
        %>
        <c:if test="${bookingMsg!=null}">
            <%bookingMsg="Booking "+bookingMsg;%>
            <p class="div_form"><%=bookingMsg%></p>            
        </c:if>        
        <div class="booking_form_div">
            <%
                session.removeAttribute("bookingMsg");
                String email = request.getParameter("emailSelect");
                if (email != null) {
                    ArrayList<Tutor> tutorList = new ArrayList();
                    Tutor bookingTutor = tutors.getTutor(email);
                    tutorList.add(bookingTutor);
                    if (tutorList.size() > 0) {
                        tutors.print(tutorList, out);
                    }
            %>
            <form class="booking_form_div" method="post" action="main.jsp">
                <%
                    bookings.addBooking(new Booking(bookingTutor.getName(), bookingTutor.getEmail(), student.getName(), student.getEmail(), bookingTutor.getSubject(), "active"));
                    bookingApp.updateXML(bookings, bookingsPath);
                    tutorApp.changeStatus(bookingTutor, "unavailable");
                %>
                <input class="button" type="submit" value="Create Booking">

            </form>
            <%}%>
        </div>

        <% if (student != null) {
                session.setAttribute("student", student);
            } else if (tutor != null) {
                session.setAttribute("tutor", tutor);
            }
        %>
    </body>
</html>
