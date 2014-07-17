#
# Copyright (c) 2014 Constant Contact
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#

module JenkinsPipelineBuilder
  module CLI
    class List < Thor
      JenkinsPipelineBuilder.registry.entries.keys.each do |entry|
        desc entry, "List all #{entry}"
        define_method(entry) do
          extensions =  JenkinsPipelineBuilder.registry.registry[:job][entry]
          extensions.each do |name, exts|
            ext = exts.first
            display_module(name, ext)
          end
        end
      end

      desc 'job_attributes', 'List all job attributes'
      def job_attributes
        extensions =  JenkinsPipelineBuilder.registry.registry[:job]
        extensions.each do |name, exts|
          # TODO: Don't just use the first
          ext = exts.first
          next unless ext.is_a? Extension
          display_module(name, ext)
        end
      end

      private

      def display_module(name, ext)
        puts "#{name}: Jenkins Name: #{ext.jenkins_name}"
      end
    end
  end
end