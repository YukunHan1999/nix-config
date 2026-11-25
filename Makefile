PROJECT_NAME := nix-config
VERSION := 1.0

# 颜色输出（终端美化）
COLOR_RESET := \033[0m
COLOR_GREEN := \033[32m
COLOR_YELLOW := \033[33m
COLOR_BLUE := \033[34m
COLOR_RED := \033[31m

# ==================== 默认目标 ====================
.PHONY: all
all: help

# ==================== 帮助信息 ====================
.PHONY: help
help: ## > 显示帮助信息
	@printf "$(COLOR_BLUE)================================================================$(COLOR_RESET)\n"
	@printf "$(COLOR_GREEN)  $(PROJECT_NAME):v$(VERSION) 项目管理工具! $(COLOR_RESET)\n"
	@printf "$(COLOR_BLUE)================================================================$(COLOR_RESET)\n"
	@printf "\n"
	@printf "$(COLOR_YELLOW)可用命令:$(COLOR_RESET)\n"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  $(COLOR_GREEN)%-20s$(COLOR_RESET) %s\n", $$1, $$2}'
	@printf "\n"

# ==================== 管理信息 ====================
.PHONY: clean-push	
clean-push: ## > 纯净推送
	@printf "$(COLOR_BLUE)→ 纯净推送 $(COLOR_RESET)\n"
	git checkout --orphan tmp; \
		git rm -rf --cached .; \
		git add -A; \
		git commit -m "clean push"; \
		git branch -D main; \
		git branch -m main; \
		git push -f origin main; \
		git branch --set-upstream-to=origin/main main
	@printf "$(COLOR_GREEN)✓ 纯净推送成功 $(COLOR_RESET)\n";

.PHONY: apply-sys	
apply-sys: ## > 应用到当前系统
	@printf "$(COLOR_BLUE)→ 应用到当前系统 $(COLOR_RESET)\n"
	sudo nixos-rebuild switch --flake .\#vm
	@printf "$(COLOR_GREEN)✓ 应用到当前系统成功 $(COLOR_RESET)\n";

.PHONY: apply-user	
apply-user: ## > 应用到当前用户
	@printf "$(COLOR_BLUE)→ 应用到当前用户 $(COLOR_RESET)\n"
	home-manager switch --flake .\#hyk@vm
	@printf "$(COLOR_GREEN)✓ 应用到当前用户成功 $(COLOR_RESET)\n";
