require "json"

class Couve::Parser
  def initialize(coverage)
    @coverage = JSON.parse(coverage, symbolize_names: true)
    @coverage[:source_files].reject! { |file| file[:covered_percent] == 100 }
    @coverage[:source_files].sort_by! { |file| file[:covered_percent] }
  end

  def to_html
    <<~HTML
      <html>
        <body>
          <div class="container mt-5">
            <h1 class="display-5">
              Coverage problems
            </h1>

            <table class="table table-hover mt-5">
              <thead>
                <tr>
                  <th class="col-1 text-end">Coverage</th>
                  <th class="col-8">File</th>
                  <th class="col-3">Not covered lines</th>
                </tr>
              </thead>
              #{body}
            </table>
          </div>

          <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
          <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
        </body>
      </html>
    HTML
  end

  private

  def body
    html = ["<tbody>"]

    @coverage[:source_files].each do |source_file|
      html << "  <tr>"
      html << "    <td class=\"col-1 text-end\">#{source_file[:covered_percent].round(2)}%</td>"
      html << "    <td class=\"col-8 text-break\">#{source_file[:name]}</td>"
      html << "    <td class=\"col-3 text-break\">#{not_covered_lines(source_file)}</td>"
      html << "  </tr>"
    end

    html << "</tbody>"

    html.join("\n        ")
  end

  def not_covered_lines(source_file)
    total_lines = JSON.parse(source_file[:coverage])

    not_covered = total_lines.each_with_index.map do |line, index|
      next if line != 0

      index + 1
    end

    not_covered.compact.join(", ")
  end
end
