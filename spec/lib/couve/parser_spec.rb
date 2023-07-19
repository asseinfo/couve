# frozen_string_literal: true

require "couve/parser"

RSpec.describe Couve::Parser do
  it "returns an html report" do
    coverage = <<~COVERAGE
      {
        "source_files": [
          {
            "blob_id": "54a416a25b04c1abed43d7abe7e00e320bc2e5f3",
            "coverage": "[null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,49,49,null,1,null,49,null,49,null,null,null,null,49,8,null,8,null,3,3,null,null,4,4,4,4,null,null,null,49,null,null,null,null,null,null,null,null,null,null,null,null,null,null]",
            "covered_percent": 89,
            "covered_strength": 22.2,
            "line_counts": {
              "missed": 0,
              "covered": 15,
              "total": 15
            },
            "name": "app/javascript/index.tsx"
          },
          {
            "blob_id": "05d22df42b81aea4c1961ba824c94bb26bac7109",
            "coverage": "[null,null,null,null,null,null,null,null,931,null,931,931,null,null,12,null,12,10,null,null,12]",
            "covered_percent": 95,
            "covered_strength": 405.57142857142856,
            "line_counts": {
              "missed": 0,
              "covered": 7,
              "total": 7
            },
            "name": "app/javascript/routes.jsx"
          },
          {
            "blob_id": "0ff76acbfdad583c05b68bc71c411b309f9d53e4",
            "coverage": "[4,4,null,4,null,4,null,null,null,4,null,null,null,4,null,null,null,4,null,4,21,null,null,null,null,null,21,null,20,null,null]",
            "covered_percent": 99,
            "covered_strength": 8.545454545454545,
            "line_counts": {
              "missed": 0,
              "covered": 11,
              "total": 11
            },
            "name": "app/graphql/resolvers/people_resolver.rb"
          }
        ]
      }
    COVERAGE

    expected = <<~HTML
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
              <tbody>
                <tr>
                  <td class="col-1 text-end">89%</td>
                  <td class="col-8 text-break">app/javascript/index.tsx</td>
                  <td class="col-3 text-break"></td>
                </tr>
                <tr>
                  <td class="col-1 text-end">95%</td>
                  <td class="col-8 text-break">app/javascript/routes.jsx</td>
                  <td class="col-3 text-break"></td>
                </tr>
                <tr>
                  <td class="col-1 text-end">99%</td>
                  <td class="col-8 text-break">app/graphql/resolvers/people_resolver.rb</td>
                  <td class="col-3 text-break"></td>
                </tr>
              </tbody>
            </table>
          </div>

          <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
          <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
        </body>
      </html>
    HTML

    subject = described_class.new(coverage)

    expect(subject.to_html).to eql expected
  end

  it "does not export files 100% covered" do
    coverage = <<~COVERAGE
      {
        "source_files": [
          {
            "coverage": "[1,1,1,1,null,1,null,1,14,null,null,1,13,13,null,13,13,null,null,1,13,null,13,null,13,null,null,1,13,null,2,null,6,null,1,null,4,null,null,13,null,null,1,4,3,null,1,null,null,null,1,26,null,null,null,1,92,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null]",
            "covered_percent": 100,
            "name": "app/javascript/index.tsx"
          },
          {
            "coverage": "[null,null,null,null,null,null,null,null,null,null,null,940,null,null,326,326,null,326,null,null,3,3,null,null,null,null,null,null,null,3,null,null,null,null,null,3,null,0,null,null,null,326,null,null,null,null,null,326,null,null,null,null,null,null,null,null,null,null,326,null,null,null,null,7,null,7,7,7,3,null,null,null,null,null,null,null,null,null,null,null,null,null,173,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,173,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,173,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,173,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,173]",
            "covered_percent": 95,
            "name": "app/javascript/routes.jsx"
          },
          {
            "coverage": "[1,1,1,1,null,1,null,1,14,null,null,1,13,13,null,13,13,null,null,1,13,null,13,null,13,null,null,1,13,null,2,null,6,null,1,null,4,null,null,13,null,null,1,4,3,null,1,null,null,null,1,26,null,null,null,1,92,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null]",
            "covered_percent": 100,
            "name": "app/graphql/resolvers/people_resolver.rb"
          }
        ]
      }
    COVERAGE

    expected = []
    expected << "<td class=\"col-1 text-end\">95%</td>"
    expected << "<td class=\"col-8 text-break\">app/javascript/routes.jsx</td>"
    expected << "<td class=\"col-3 text-break\">38</td>"

    subject = described_class.new(coverage)

    expect(subject.to_html).to include expected.join("\n            ")
  end

  it "sorts by less covered first" do
    coverage = <<~COVERAGE
      {
        "source_files": [
          {
            "coverage": "[1,1,10,null,null,null,null,null,null,10,null,null,1,7,null,7,4,null,4,null,3,null,null,null,1,null,1,0,null,null,null,null,null,1,7,null,null,null,null,null,null,null]",
            "covered_percent": 93.33333333333333,
            "name": "app/javascript/index.tsx"
          },
          {
            "coverage": "[null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,6,null,6,null,null,12,0,null,12,null,null,null,6]",
            "covered_percent": 83.33333333333334,
            "name": "app/javascript/routes.jsx"
          },
          {
            "coverage": "[2,2,2,null,null,null,null,null,null,2,2,2,2,null,null,null,2,null,2,2,null,0,null,0,null,null,2,null,null,2,2,null,0,0,null,0,null,null,0,null,2,null,0,null,null,null,2,0,0,null,0,null,null]",
            "covered_percent": 60,
            "name": "app/graphql/resolvers/people_resolver.rb"
          }
        ]
      }
    COVERAGE

    expected = []
    expected << "<tr>"
    expected << "  <td class=\"col-1 text-end\">60%</td>"
    expected << "  <td class=\"col-8 text-break\">app/graphql/resolvers/people_resolver.rb</td>"
    expected << "  <td class=\"col-3 text-break\">22, 24, 33, 34, 36, 39, 43, 48, 49, 51</td>"
    expected << "</tr>"
    expected << "<tr>"
    expected << "  <td class=\"col-1 text-end\">83.33%</td>"
    expected << "  <td class=\"col-8 text-break\">app/javascript/routes.jsx</td>"
    expected << "  <td class=\"col-3 text-break\">24</td>"
    expected << "</tr>"
    expected << "<tr>"
    expected << "  <td class=\"col-1 text-end\">93.33%</td>"
    expected << "  <td class=\"col-8 text-break\">app/javascript/index.tsx</td>"
    expected << "  <td class=\"col-3 text-break\">28</td>"
    expected << "</tr>"

    subject = described_class.new(coverage)

    expect(subject.to_html).to include expected.join("\n          ")
  end

  it "exports not covered lines numbers" do
    coverage = <<~COVERAGE
      {
        "source_files": [
          {
            "coverage": "[1,1,10,null,null,null,null,null,null,10,null,null,1,7,null,7,4,null,4,null,3,null,null,null,1,null,1,0,null,null,null,null,null,1,7,null,null,null,null,null,null,null]",
            "covered_percent": 93.33333333333333,
            "name": "app/javascript/index.tsx"
          },
          {
            "coverage": "[null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,6,null,6,null,null,12,0,null,12,null,null,null,6]",
            "covered_percent": 83.33333333333334,
            "name": "app/javascript/routes.jsx"
          },
          {
            "coverage": "[2,2,2,null,null,null,null,null,null,2,2,2,2,null,null,null,2,null,2,2,null,0,null,0,null,null,2,null,null,2,2,null,0,0,null,0,null,null,0,null,2,null,0,null,null,null,2,0,0,null,0,null,null]",
            "covered_percent": 60,
            "name": "app/graphql/resolvers/people_resolver.rb"
          }
        ]
      }
    COVERAGE

    expected = []
    expected << "<tr>"
    expected << "  <td class=\"col-1 text-end\">60%</td>"
    expected << "  <td class=\"col-8 text-break\">app/graphql/resolvers/people_resolver.rb</td>"
    expected << "  <td class=\"col-3 text-break\">22, 24, 33, 34, 36, 39, 43, 48, 49, 51</td>"
    expected << "</tr>"
    expected << "<tr>"
    expected << "  <td class=\"col-1 text-end\">83.33%</td>"
    expected << "  <td class=\"col-8 text-break\">app/javascript/routes.jsx</td>"
    expected << "  <td class=\"col-3 text-break\">24</td>"
    expected << "</tr>"
    expected << "<tr>"
    expected << "  <td class=\"col-1 text-end\">93.33%</td>"
    expected << "  <td class=\"col-8 text-break\">app/javascript/index.tsx</td>"
    expected << "  <td class=\"col-3 text-break\">28</td>"
    expected << "</tr>"

    subject = described_class.new(coverage)

    expect(subject.to_html).to include expected.join("\n          ")
  end
end
