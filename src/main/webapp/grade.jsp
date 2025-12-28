<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP Student Grade Calculator</title>

    <style>
        * {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0;
        }

        .container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            padding: 40px;
            width: 500px;
        }

        h1 {
            text-align: center;
            margin-bottom: 10px;
        }

        .subtitle {
            text-align: center;
            color: #666;
            margin-bottom: 30px;
        }

        label {
            font-weight: 600;
        }

        input {
            width: 100%;
            padding: 14px;
            border-radius: 10px;
            border: 2px solid #ddd;
            margin-top: 8px;
            font-size: 16px;
        }

        .btn-group {
            display: flex;
            gap: 15px;
            margin-top: 20px;
        }

        button {
            flex: 1;
            padding: 14px;
            border-radius: 10px;
            border: none;
            font-size: 16px;
            cursor: pointer;
            font-weight: 600;
        }

        .calculate {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
        }

        .reset {
            background: #e0e0e0;
            color: #333;
        }

        .result {
            margin-top: 30px;
            padding: 25px;
            border-radius: 15px;
            text-align: center;
            display: none;
        }

        .grade-A {
            background: #d4edda;
            color: #155724;
        }

        .grade-B {
            background: #fff3cd;
            color: #856404;
        }

        .grade-C {
            background: #f8d7da;
            color: #721c24;
        }

        .grade-invalid {
            background: #f8f9fa;
            color: #6c757d;
        }

        .grade-display {
            font-size: 32px;
            margin: 10px 0;
        }
    </style>

    <script>
        function resetForm() {
            const marksInput = document.getElementById("marks");
            marksInput.value = "";
            marksInput.placeholder = "Enter marks between 0 and 100";

            document.getElementById("resultContainer").style.display = "none";
        }
    </script>
</head>

<body>
<div class="container">

    <h1>📚 Student Grade Calculator</h1>
    <p class="subtitle">Enter marks to calculate grade (0–100)</p>

    <form method="post">
        <label>Enter Student Marks</label>
        <input type="number"
               id="marks"
               name="marks"
               min="0"
               max="100"
               placeholder="Enter marks between 0 and 100"
               required>

        <div class="btn-group">
            <button type="submit" class="calculate">Calculate</button>
            <button type="button" class="reset" onclick="resetForm()">Reset</button>
        </div>
    </form>

    <div id="resultContainer" class="result">
        <div class="marks-display"></div>
        <div class="grade-display"></div>
        <div class="message"></div>
    </div>

<%
    String marksStr = request.getParameter("marks");

    if (marksStr != null && !marksStr.trim().isEmpty()) {
        try {
            int marks = Integer.parseInt(marksStr.trim());
            String grade = "", msg = "", css = "";

            if (marks >= 90 && marks <= 100) {
                grade = "A";
                msg = "Excellent! Keep it up!";
                css = "grade-A";
            } else if (marks >= 75) {
                grade = "B";
                msg = "Good job! Room for improvement.";
                css = "grade-B";
            } else if (marks >= 50) {
                grade = "C";
                msg = "You passed. Try harder next time.";
                css = "grade-C";
            } else if (marks >= 0) {
                grade = "F";
                msg = "Failed. Need more practice.";
                css = "grade-C";
            } else {
                throw new Exception();
            }

            out.println("<script>");
            out.println("document.querySelector('.marks-display').innerText='Marks Obtained: " + marks + "/100';");
            out.println("document.querySelector('.grade-display').innerText='Grade: " + grade + "';");
            out.println("document.querySelector('.message').innerText='" + msg + "';");
            out.println("let r=document.getElementById('resultContainer');");
            out.println("r.className='result " + css + "'; r.style.display='block';");
            out.println("document.getElementById('marks').value='" + marks + "';");
            out.println("</script>");

        } catch (Exception e) {
            out.println("<script>");
            out.println("let r=document.getElementById('resultContainer');");
            out.println("r.innerText='Invalid input! Enter numbers 0–100 only.';");
            out.println("r.className='result grade-invalid'; r.style.display='block';");
            out.println("</script>");
        }
    }
%>

</div>
</body>
</html>
