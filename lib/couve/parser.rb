# frozen_string_literal: true

require "json"

module Couve
  class Parser
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
                    <th class="col-1" colspan="2">Coverage</th>
                    <th class="col-7">File</th>
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

    # rubocop:disable Metrics/MethodLength
    # rubocop:disable Metrics/AbcSize
    def body
      html = ["<tbody>"]

      @coverage[:source_files].each do |source_file|
        percentage = source_file[:covered_percent].round(2)
        bg_color = percentage_bar_color(percentage)

        html << "  <tr>"
        html << "    <td class=\"col-1\">"
        html << "      <div class=\"progress\">"
        html << "        <div"
        html << "          class=\"progress-bar #{bg_color}\""
        html << "          role=\"progressbar\""
        html << "          style=\"width: #{percentage}%;\""
        html << "          aria-valuenow=\"#{percentage}\""
        html << "          aria-valuemin=\"0\" aria-valuemax=\"100\">"
        html << "        </div>"
        html << "      </div>"
        html << "    </td>"
        html << "    <td class=\"col-1\">#{percentage}%</td>"
        html << "    <td class=\"col-8 text-break\">#{source_file[:name]}</td>"
        html << "    <td class=\"col-3 text-break\">#{not_covered_lines(source_file)}</td>"
        html << "  </tr>"
      end

      html << "</tbody>"

      html.join("\n        ")
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/MethodLength

    def percentage_bar_color(percentage)
      if percentage < 33.33
        "bg-danger"
      elsif percentage < 66.66
        "bg-warning"
      else
        "bg-success"
      end
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
end
