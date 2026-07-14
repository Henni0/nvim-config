return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    -- Compiler: latexmk liest die projektlokale .latexmkrc
    -- (pdflatex -shell-escape -synctex=1) automatisch.
    vim.g.vimtex_compiler_method = "latexmk"

    -- PDF-Viewer: Skim (macOS), mit SyncTeX Vor-/Rückwärtssuche.
    vim.g.vimtex_view_method = "skim"
    vim.g.vimtex_view_skim_sync = 1 -- nach dem Kompilieren zur Cursorzeile springen
    vim.g.vimtex_view_skim_activate = 1 -- Skim in den Vordergrund holen

    -- Quickfix nur bei echten Fehlern öffnen, nicht bei jeder Warnung.
    vim.g.vimtex_quickfix_open_on_warning = 0

    -- Kein eigenes Mapping-Set überschreiben lassen.
    vim.g.vimtex_mappings_enabled = 1
  end,
}
