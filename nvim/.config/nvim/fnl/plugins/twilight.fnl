(module plugins.twilight
  {autoload {onedarkpro-helpers onedarkpro.helpers
             : twilight}})

(defn config []
  "Configure twilight.nvim"
  (let [c (onedarkpro-helpers.get_colors "onedark")]
    ;; Call the setup function
    (twilight.setup
      {:dimming
        {:alpha 1.0
         :color [ c.comment]}
       :context 10})))
