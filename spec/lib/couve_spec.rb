# frozen_string_literal: true

RSpec.describe Couve do
  it "has a version number" do
    expect(Couve::VERSION).not_to be nil
  end

  describe ".start" do
    it "generates the html report" do
      output_file = "tmp/coverage.html"

      File.delete(output_file) if File.exist?(output_file)
      expect(File.exist?(output_file)).to be false

      subject.start(
        "spec/fixtures/codeclimate.json",
        output_file
      )

      expect(File.exist?(output_file)).to be true

      generated = File.read(output_file)
      expected = File.read("spec/fixtures/coverage.html")

      expect(generated).to eql expected
    end
  end
end
