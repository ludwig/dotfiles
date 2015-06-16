
;; http://www.reddit.com/r/emacs/comments/jfrqm/what_does_your_tab_key_do/
;; https://gist.github.com/1140530
(defun smart-tab ()
  "If mark is active, indents region. Else if point is at the end of a symbol,
   expands it. Else indents the current line. Acts as normal in minibuffer."
  (interactive)
  (cond (mark-active (indent-region (region-beginning) (region-end)))
        ((and (looking-at "\\_>") (not (looking-at "end")))
         (hippie-expand nil))
        (t (indent-for-tab-command))))

