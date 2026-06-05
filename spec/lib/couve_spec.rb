# frozen_string_literal: true

require "fileutils"

RSpec.describe Couve do
  it "has a version number" do
    expect(Couve::VERSION).not_to be nil
  end

  describe ".start" do
    it "generates the html report" do
      output_file = "tmp/coverage.html"

      FileUtils.rm_f(output_file)
      expect(File.exist?(output_file)).to be false

      subject.start(["spec/fixtures/codeclimate.json", output_file])

      expect(File.exist?(output_file)).to be true

      generated = File.read(output_file)
      expected = File.read("spec/fixtures/coverage.html")

      expect(generated).to eql expected
    end

    it "generates the markdown report when the output file ends with .md" do
      output_file = "tmp/coverage.md"

      FileUtils.rm_f(output_file)
      expect(File.exist?(output_file)).to be false

      subject.start(["spec/fixtures/codeclimate.json", output_file])

      expect(File.exist?(output_file)).to be true

      generated = File.read(output_file)

      expect(generated).to start_with "## Coverage report\n"
      expect(generated).to include "| Rating | Coverage | File | Not covered lines |"
      expect(generated).to_not include "<html>"
    end

    it "filters to the files passed via --changed-files" do
      output_file = "tmp/changed.md"
      list_file = "tmp/changed.txt"

      FileUtils.rm_f(output_file)
      File.write(list_file, "app/javascript/routes.jsx\n")

      subject.start(["spec/fixtures/codeclimate.json", output_file, "--changed-files", list_file])

      generated = File.read(output_file)
      expect(generated).to include "app/javascript/routes.jsx"
      expect(generated).to_not include "people_resolver.rb"
    end

    it "reads the changed files from stdin when --changed-files is -" do
      output_file = "tmp/changed_stdin.md"

      FileUtils.rm_f(output_file)
      allow($stdin).to receive(:read).and_return("./app/javascript/routes.jsx\n")

      subject.start(["spec/fixtures/codeclimate.json", output_file, "--changed-files", "-"])

      generated = File.read(output_file)
      expect(generated).to include "app/javascript/routes.jsx"
      expect(generated).to_not include "people_resolver.rb"
    end
  end
end
