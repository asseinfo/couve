# frozen_string_literal: true

require "couve/version"
require "couve/parser"

module Couve
  def self.start
    coverage_file = ARGV[0]
    output_file = ARGV[1]

    coverage = File.read(coverage_file)
    parser = Couve::Parser.new(coverage)

    File.open(output_file, "w") do |f|
      f.puts parser.to_html
    end
  end
end
