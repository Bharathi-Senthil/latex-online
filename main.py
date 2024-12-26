from fastapi import FastAPI, HTTPException
import requests

app = FastAPI()

@app.post("/compile_latex")
def compile_latex(content: str):
    try:
        # Send the LaTeX content to the Docker container via HTTP
        url = "http://localhost:2700/compile?text=" + content
        response = requests.get(url)

        if response.status_code != 200:
            return {"error": response.text}

        # The response will be the PDF as binary
        pdf_data = response.content

        # Save the PDF to a file
        with open("output.pdf", "wb") as f:
            f.write(pdf_data)

        return {"message": "LaTeX document compiled successfully", "file": "output.pdf"}
    except Exception as e:
        return {"error": str(e)}
