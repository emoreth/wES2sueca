# encoding: utf-8
# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file was generated by Cucumber-Rails and is only here to get you a head start
# These step definitions are thin wrappers around the Capybara/Webrat API that lets you
# visit pages, interact with widgets and make assertions about page content.
#
# If you use these step definitions as basis for your features you will quickly end up
# with features that are:
#
# * Hard to maintain
# * Verbose to read
#
# A much better approach is to write your own higher level step definitions, following
# the advice in the following blog posts:
#
# * http://benmabey.com/2008/05/19/imperative-vs-declarative-scenarios-in-user-stories.html
# * http://dannorth.net/2011/01/31/whose-domain-is-it-anyway/
# * http://elabs.se/blog/15-you-re-cuking-it-wrong
#


require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

# Single-line step scoper
Quando /^(.*) dentro de ([^:]+)$/ do |step, parent|
  with_scope(parent) { Quando step }
end

# Multi-line step scoper
Quando /^(.*) dentro de ([^:]+):$/ do |step, parent, table_or_string|
  with_scope(parent) { Quando "#{step}:", table_or_string }
end

Dado /^que eu estou na (.+)$/ do |page_name|
  Given %{I am on #{page_name}}
end

Quando /^eu vou para (.+)$/ do |page_name|
  When %{I go to #{page_name}}
end

Quando /^eu aperto "([^"]*)"$/ do |button|
  When %{I press "#{button}"}
end

Quando /^eu clico "([^"]*)"$/ do |link|
  When %{I follow "#{link}"}
end

Quando /^eu preencho "([^"]*)" com "([^"]*)"$/ do |field, value|
  When %{I fill in "#{field}" with "#{value}"}
end

Quando /^eu preencho "([^"]*)" para "([^"]*)"$/ do |value, field|
  When %{I fill in "#{value}" for "#{field}"}
end

Quando /^eu preencho o seguinte:$/ do |fields|
  When %{I fill in the following:}, fields
end

Quando /^eu seleciono "([^"]*)" de "([^"]*)"$/ do |value, field|
  When %{I select "#{value}" from "#{field}"}
end

Quando /^eu seleciono "([^"]*)" como a data e a hora$/ do |time|
  When %{I select "#{time}" as the date and time}
end

Quando /^eu seleciono "([^"]*)" como a data e a hora "([^"]*)"$/ do |datetime, datetime_label|
  When %{I select "#{datetime}" as the "#{datetime_label}" date and time}
end

Quando /^eu seleciono "([^"]*)" como a hora$/ do |time|
  When %{I select "#{time}" as the time}
end

Quando /^eu seleciono "([^"]*)" como a hora "([^"]*)"$/ do |time, time_label|
  When %{I select "#{time}" as the "#{time_label}" time}
end

Quando /^eu seleciono "([^"]*)" como a data$/ do |date|
  When %{I select "#{date}" as the date}
end

Quando /^eu seleciono "([^"]*)" como a data "([^"]*)"$/ do |date, date_label|
  When %{I select "#{date}" as the "#{date_label}" date}
end

Quando /^eu seleciono "([^"]*)" como "([^"]*)"$/ do |date, date_label|
  When %{I select "#{date}" as the "#{date_label}" date}
end

Quando /^eu marco "([^"]*)"$/ do |field|
  When %{I check "#{field}"}
end

Quando /^eu desmarco "([^"]*)"$/ do |field|
  When %{I uncheck "#{field}"}
end

Quando /^eu escolho "([^"]*)"$/ do |field|
  When %{I choose "#{field}"}
end

Quando /^eu anexo o arquivo em "([^"]*)" a "([^"]*)"$/ do |path, field|
  When %{I attach the file "#{path}" to "#{field}"}
end

Então /^eu devo ver "([^"]*)"$/ do |text|
  Then %{I should see "#{text}"}
end

Então /^eu devo ver \/([^\/]*)\/$/ do |regexp|
  Then %{I should see /#{regexp}/}
end

Então /^eu não devo ver "([^"]*)"$/ do |text|
  Then %{I should not see "#{text}"}
end

Então /^eu não devo ver \/([^\/]*)\/$/ do |regexp|
  Then %{I should not see /#{regexp}/}
end

Então /^o campo "([^"]*)" deve conter "([^"]*)"$/ do |field, value|
  Then %{the "#{field}" field should contain "#{value}"}
end

Então /^o campo "([^"]*)" não deve conter "([^"]*)"$/ do |field, value|
  Then %{the "#{field}" field should not contain "#{value}"}
end

Então /^o checkbox "([^"]*)" deve estar marcado$/ do |label|
  Then %{the "#{label}" checkbox should be checked}
end

Então /^o checkbox "([^"]*)" não deve estar marcado$/ do |label|
  Then %{the "#{label}" checkbox should not be checked}
end

Então /^eu devo estar na (.+)$/ do |page_name|
  Then %{I should be on #{page_name}}
end

Então /^mostre-me a página$/ do
  Then %{show me the page}
end