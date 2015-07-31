import sublime, sublime_plugin
import re
import os

class GoToSymbolInProjectNow(sublime_plugin.TextCommand):
	def run(self, edit):
		view = self.view


		# self.view.run_command("go_to_symbol_in_project_now")
		view.window().run_command("find_under_expand")

		selection = view.sel()
		region1 = selection[0]
		selection_text = view.substr(region1)
		sublime.status_message(selection_text)

		view.window().run_command("show_overlay", args={"overlay": "goto", "text": "@ " + selection_text})

		# view.window().run_command("goto_symbol_in_project")
		# view.insert(edit, 0, selection_text)
