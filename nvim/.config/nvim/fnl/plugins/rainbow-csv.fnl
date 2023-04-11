(module plugins.rainbow-csv
  {autoload {nordic-palette nordic.palette}})

(defn init []
  "Initialize raindow-csv.vim"
  (let [c nordic-palette]
    (set vim.g.rcsv_colorpairs
      [[1 c.red]
       [14 c.cyan]
       [11 c.orange]
       [6 c.bright_cyan]
       [3 c.yellow]
       [4 c.blue]
       [2 c.green]
       [12 c.intense_blue]
       [5 c.purple]])))
