# 1. Instalar o Ollama
# Acesse: https://ollama.com/download
# Faça o download e instale o Ollama de acordo com seu sistema operacional (Windows, macOS ou Linux).
# Após instalado, abra o terminal e execute para verificar:
#   ollama version
# 
# 2. Baixar o modelo Qwen2.5-VL:7B
# Obs.: Este modelo suporta entrada multimodal e tem suporte a texto + imagem (mesmo que você só use texto neste caso).
# No terminal:
#   ollama pull qwen2.5vl:7b
# Aguarde o download (~7–9 GB, dependendo da versão).
# 
# 3. Verifique se o modelo está disponível
# ollama list
# Você deve ver algo como:
#   MODEL              SIZE
# qwen2.5vl:7b       7.1 GB
# 
# 4. Inicie o Ollama como servidor local (caso não esteja rodando)
# Por padrão, o Ollama inicia automaticamente ao chamar um modelo.
# Para garantir, rode:
#   ollama run qwen2.5vl:7b
# Você verá uma resposta inicial do modelo, e ele ficará escutando em http://localhost:11434.

# teste de conexão
test <- httr::GET("http://localhost:11434")
httr::status_code(test)

# --- CONFIG ---
base_url <- "http://localhost:11434/api/generate"
model_name <- "Qwen3-VL:7B"
message <- "RESPONDA APENAS COM UM TEXTO PURO, SEM FORMATAÇÃO EM MARKDOWN
Me de uma interpretação do dataset em detalhes, explorando todas as colunas e suas evoluções. Inclua qualquer insight ou anomalia:

Columns:
{{ column names }}

Data:
{{ data preview }}
"

# simulate a dataset output table
# data_frame <- data.frame(
#   Column1 = c(1, 2, 3, 4, 5),
#   Column2 = c("A", "B", "C", "D", "E"),
#   Column3 = c(TRUE, FALSE, TRUE, FALSE, TRUE)
# )

## --- PREPARE PAYLOAD ---
payload <- list(
  model = model_name,
  prompt = message,
  stream = FALSE,
  temperature = 0,
  data = jsonlite::toJSON(data_frame, auto_unbox = TRUE)
)

column_names <- paste(names(data_frame), collapse = ", ")
data_preview <- data_frame
payload$prompt <- gsub("\\{\\{ column names \\}\\}", column_names, payload$prompt)
payload$prompt <- gsub("\\{\\{ data preview \\}\\}", jsonlite::toJSON(data_preview, auto_unbox = TRUE), payload$prompt)

## --- SEND TO OLLAMA ---
response <- httr::POST(
  url = base_url,
  body = jsonlite::toJSON(payload, auto_unbox = TRUE),
  encode = "json",
  httr::content_type_json()
)

## --- PARSE RESPONSE ---
if (response$status_code == 200) {
  result <- httr::content(response, "parsed")
  print(result$response)
} else {
  print("Error in the request")
}
