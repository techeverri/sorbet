#ifndef RUBY_TYPER_LSP_REQUESTS_DOCUMENT_HIGHLIGHT_H
#define RUBY_TYPER_LSP_REQUESTS_DOCUMENT_HIGHLIGHT_H

#include "main/lsp/LSPTask.h"

namespace sorbet::realmain::lsp {
class TextDocumentPositionParams;
class DocumentHighlightTask final : public LSPRequestTask {
    std::unique_ptr<TextDocumentPositionParams> params;

public:
    DocumentHighlightTask(const LSPConfiguration &config, MessageId id,
                          std::unique_ptr<TextDocumentPositionParams> params);

    std::unique_ptr<ResponseMessage> runRequest(LSPTypecheckerInterface &typechecker) override;
};

} // namespace sorbet::realmain::lsp

#endif
