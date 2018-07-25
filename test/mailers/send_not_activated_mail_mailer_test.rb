require 'test_helper'

class SendNotActivatedMailMailerTest < ActionMailer::TestCase
   test "Send first level activation reminder mail" do
       SendNotActivatedMailMailer.with(location: Location.first).first_activation_reminder
   end

   test "Send second level activation reminder mail" do
       SendNotActivatedMailMailer.with(location: Location.first).second_activation_reminder
   end

   test "Send last level activation reminder mail" do
       SendNotActivatedMailMailer.with(location: Location.first).last_activation_reminder
   end
end
