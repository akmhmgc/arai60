# 問題番号を引数として受け取り、ディレクトリを作成してテンプレートファイルをコピーする
# 使用方法: make create PROBLEM=111

.PHONY: create help

# デフォルトターゲット
help:
	@echo "使用方法:"
	@echo "  make create PROBLEM=<問題番号>  # 指定した問題番号のディレクトリを作成し、テンプレートファイルをコピー"
	@echo "  make help                      # このヘルプを表示"
	@echo ""
	@echo "例:"
	@echo "  make create PROBLEM=111        # 111ディレクトリを作成"
	@echo "  make create PROBLEM=abc123     # abc123ディレクトリを作成"

# 問題ディレクトリを作成し、テンプレートファイルをコピー
create:
	@if [ -z "$(PROBLEM)" ]; then \
		echo "エラー: PROBLEM引数を指定してください"; \
		echo "例: make create PROBLEM=111"; \
		exit 1; \
	fi
	@echo "問題 $(PROBLEM) のディレクトリを作成中..."
	@mkdir -p $(PROBLEM)
	@cp template/*.md $(PROBLEM)/
	@echo "完了: $(PROBLEM)ディレクトリにテンプレートファイルをコピーしました"
	@echo "作成されたファイル:"
	@ls -la $(PROBLEM)/
