import os
import uvicorn
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import google.generativeai as genai

app = FastAPI()

# APIキーを取得
GOOGLE_API_KEY = os.environ.get("GOOGLE_API_KEY")
if not GOOGLE_API_KEY:
    raise ValueError("GOOGLE_API_KEY is not set")

genai.configure(api_key = GOOGLE_API_KEY)
model = genai.GenerativeModel("gemini-2.5-flash")
class ChatRequest(BaseModel):
    message: str
    
@app.get("/")
def health_check():
    return{"status":"ok"}
@app.post("/v1/chat")
def chat(req:ChatRequest):
    try:
        response = model.generate_content(req.message)
        return{"response": response.text}
    except Exception as e:
        raise HTTPException(status_code = 500, detail = str(e))
    
if __name__ == "__main__":
    uvicorn.run(app, host = "0.0.0.0", port = 8080)
    
