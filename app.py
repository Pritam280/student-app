from flask import Flask, request, jsonify

app = Flask(__name__)
students = {}

@app.route("/")
def home():
    return "Student Result App Running!"

@app.route("/add", methods=["POST"])
def add_student():
    data = request.json
    students[data["name"]] = data["marks"]
    return jsonify({"message": "Student added successfully"})

@app.route("/get/<name>")
def get_student(name):
    return jsonify({"marks": students.get(name, "Not Found")})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)

