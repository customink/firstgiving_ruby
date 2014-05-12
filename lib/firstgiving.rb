require 'rubygems'
require 'firstgiving/version'
require 'firstgiving/base'
require 'firstgiving/response'
require 'firstgiving/donation'
require 'firstgiving/lookup'
require 'firstgiving/search'

# Donation API
# Transaction API
# Search API

module FirstGiving
  class Configuration
    attr_accessor :application_key, :security_token, :options

    def initialize
      self.application_key = nil
      self.security_token  = nil
      self.options         = {}
      set_defaults
    end

    def set_defaults
      options[:verbose] ||= false
      options[:read_timeout] ||= 30
      options[:use_ssl] ||= false
      options[:use_staging] ||= true
    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration) if block_given?
  end

  def self.lookup
    @lookup ||= Lookup.new
  end

  def self.search
    @search ||= Search.new
  end

  def self.donation
    @donation ||= Donation.new
  end
end

FG = FirstGiving
