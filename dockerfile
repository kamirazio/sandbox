FROM image-registry.apps.2.rahti.csc.fi/noppe-public-images/jupyter-datascience:2024-07-17

# 必要なパッケージをインストール
USER root
RUN apt-get update && apt-get install -y \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Node.jsとnpmをインストール（フロントエンド開発向け）
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g npm

# JupyterLabの拡張機能
RUN pip install --no-cache-dir \
    jupyterlab \
    jupyterlab-git \
    jupyterlab-lsp \
    python-lsp-server \
    flake8 \
    autopep8 \
    black

# PythonのWebフレームワークやライブラリをインストール
RUN pip install --no-cache-dir \
    flask \
    django \
    jinja2 \
    pandas \
    numpy \
    requests

# フロントエンド開発用ツール
RUN npm install -g \
    live-server \
    eslint \
    prettier \
    typescript

# 作業ディレクトリを作成
WORKDIR /home/jovyan/work

# ポートを開放
EXPOSE 8888

# Jupyter Notebookを起動
CMD ["start-notebook.sh", "--NotebookApp.token=''", "--NotebookApp.allow_origin='*'"]
