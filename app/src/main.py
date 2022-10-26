from pathlib import Path

from fastapi import FastAPI
from fastapi.responses import RedirectResponse
from fastapi.staticfiles import StaticFiles

app = FastAPI()
static_dir = Path(__file__).parent / "static"
app.mount("/s", name="static", app=StaticFiles(directory=str(static_dir)))


@app.get("/")
async def main():
    return RedirectResponse("/s/index.html")


@app.get("/api")
async def api():
    return {"message": "Hello world!"}
