# syntax=docker/dockerfile:1.7

FROM runpod/worker-comfyui:5.8.5-base

# Custom node needed by existing Megumin Suite workflows.
RUN comfy-node-install rgthree-comfy

# Anima support files required by Anima-family Qwen Image workflows.
RUN comfy model download \
  --url https://huggingface.co/circlestone-labs/Anima/resolve/main/split_files/diffusion_models/anima-base-v1.0.safetensors \
  --relative-path models/diffusion_models \
  --filename anima-base-v1.0.safetensors

RUN comfy model download \
  --url https://huggingface.co/circlestone-labs/Anima/resolve/main/split_files/text_encoders/qwen_3_06b_base.safetensors \
  --relative-path models/text_encoders \
  --filename qwen_3_06b_base.safetensors

RUN comfy model download \
  --url https://huggingface.co/circlestone-labs/Anima/resolve/main/split_files/vae/qwen_image_vae.safetensors \
  --relative-path models/vae \
  --filename qwen_image_vae.safetensors

# RI-MIX Illustrious Anima checkpoint.
# CivitAI model page: https://civitai.com/models/996495/ri-mix-illustrious-anima
RUN --mount=type=secret,id=civitai_token \
  CIVITAI_API_TOKEN="$(cat /run/secrets/civitai_token)" && \
  export CIVITAI_API_TOKEN && \
  comfy model download \
    --url "https://civitai.com/api/download/models/3020951" \
    --relative-path models/diffusion_models \
    --filename ri-mix-illustrious-anima.safetensors

# Optional turbo LoRA for switching back to the base Anima setup.
RUN --mount=type=secret,id=civitai_token \
  CIVITAI_API_TOKEN="$(cat /run/secrets/civitai_token)" && \
  export CIVITAI_API_TOKEN && \
  comfy model download \
    --url "https://civitai.com/api/download/models/2877687" \
    --relative-path models/loras \
    --filename anima_turbo.safetensors
