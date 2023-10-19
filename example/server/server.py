from flask import Flask, send_from_directory
import os

app = Flask(__name__)

# Define the folder where markdown files are stored
markdown_folder = 'online_user_manual_1'


@app.route('/')
def index():
    # List all available markdown files
    files = os.listdir(markdown_folder)
    markdown_files = [f for f in files if f.endswith('.md')]
    return '\n'.join([f'<a href="/{filename}">{filename}</a>' for filename in markdown_files])


@app.route('/<path:filename>')
def serve_markdown(filename):
    # Serve the requested markdown file
    return send_from_directory(markdown_folder, filename)


if __name__ == '__main__':
    app.run(debug=True)
