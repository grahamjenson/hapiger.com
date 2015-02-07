require 'github/markdown'
file = 'README.md'
$README = GitHub::Markdown.render_gfm(File.read(file)).gsub(/\n/, "&#x000A;")