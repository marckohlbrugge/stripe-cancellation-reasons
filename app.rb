require "thor"
require "stripe"
require "io/console"

class StripeCLI < Thor
  desc "cancellations", "Fetch and display grouped cancellation reasons for all canceled subscriptions"
  method_option :api_key, aliases: "-k", type: :string, desc: "Stripe API Key"

  def cancellations
    api_key = options[:api_key] || ENV["STRIPE_API_KEY"] || prompt_for_api_key
    Stripe.api_key = api_key

    reasons_count = Hash.new { |hash, key| hash[key] = {count: 0, comments: []} }
    total_cancellations = 0

    Stripe::Subscription.list(status: "canceled").auto_paging_each do |subscription|
      detail = subscription.cancellation_details || {}
      comment = detail["comment"]
      feedback = detail["feedback"] || detail["reason"] || "No reason provided"

      reasons_count[feedback][:count] += 1
      reasons_count[feedback][:comments] << comment if comment
      total_cancellations += 1
    end

    sorted_reasons = reasons_count.sort_by { |_, data| -data[:count] }

    sorted_reasons.each do |reason, data|
      percentage = (data[:count].to_f / total_cancellations * 100).round(2)
      puts "Reason: #{reason} - Count: #{data[:count]} (#{percentage}%)"

      unless data[:comments].empty?
        data[:comments].each do |comment|
          puts "  Comment: #{comment}"
        end
      end
    end
  end

  private

  def prompt_for_api_key
    print "Please enter your Stripe API Key: "
    STDIN.noecho(&:gets).chomp
  end
end

StripeCLI.start(ARGV)
