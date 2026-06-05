# frozen_string_literal: true

require "optparse"

require_relative "couve/version"
require_relative "couve/parser"

module Couve
  def self.start(argv = ARGV)
    coverage_file, output_file, changed_files_source, fail_on_low_coverage = parse_arguments(argv)

    coverage = File.read(coverage_file)
    parser = Couve::Parser.new(coverage, changed_files: changed_files(changed_files_source))

    report = output_file.end_with?(".md") ? parser.to_markdown : parser.to_html

    File.open(output_file, "w") { |f| f.puts report }

    return unless fail_on_low_coverage && parser.low_coverage?

    warn "couve: coverage below #{Couve::Parser::GREEN_THRESHOLD}% in #{parser.low_coverage_files.join(", ")}"
    exit 1
  end

  def self.parse_arguments(argv) # rubocop:disable Metrics/MethodLength
    argv = argv.dup
    changed_files_source = nil
    fail_on_low_coverage = false

    OptionParser.new do |opts|
      opts.on("--changed-files PATH", "Only report the files listed in PATH (use - for stdin)") do |path|
        changed_files_source = path
      end

      opts.on("--fail-on-low-coverage",
              "Exit 1 if any reported file is below #{Couve::Parser::GREEN_THRESHOLD}% coverage") do
        fail_on_low_coverage = true
      end
    end.parse!(argv)

    [argv[0], argv[1], changed_files_source, fail_on_low_coverage]
  end

  def self.changed_files(source)
    return nil unless source

    contents = source == "-" ? $stdin.read : File.read(source)

    contents.lines.map { |line| line.strip.delete_prefix("./") }.reject(&:empty?)
  end
end
