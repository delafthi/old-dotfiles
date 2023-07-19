(module plugins.rainbow-csv
  {autoload {onedarkpro-helpers onedarkpro.helpers}})

(defn init []
  "Initialize raindow-csv.vim"
  (let [c (onedarkpro-helpers.get_colors "onedark")]
    (set vim.g.rcsv_colorpairs
      [[1 c.red]
       [2 c.green]
       [3 c.yellow]
       [4 c.blue]
       [5 c.purple]
       [6 c.cyan]
       [7 c.white]])))
