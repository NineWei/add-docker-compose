FROM python:3.11-slim

# 2. Definir o diretório de trabalho dentro do contêiner.
WORKDIR /app

# 3. Copiar o arquivo de dependências primeiro para aproveitar o cache do Docker.
# Se este arquivo não mudar, o Docker reutilizará a camada de instalação de dependências.
COPY requirements.txt .

# 4. Instalar as dependências do projeto.
# A flag --no-cache-dir reduz o tamanho final da imagem.
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copiar o restante do código da aplicação para o diretório de trabalho.
COPY . .

# 6. Expor a porta em que a aplicação será executada.
EXPOSE 8000

# 7. Definir o comando para iniciar a aplicação.
# Usamos 0.0.0.0 para que o servidor seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]

