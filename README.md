Simple Ruby CLI to see a breakdown of Stripe subscription cancellations and their reasons.

### Usage

1. Get your Stripe API key here: https://dashboard.stripe.com/apikeys
2. `git clone https://github.com/marckohlbrugge/stripe-cancellation-reasons.git`
3. `cd stripe-cancellation-reasons`
4. `bundle install`
5. `bundle exec ruby app.rb`

### Example

```sh
bundle exec ruby app.rb cancellations
Reason: unused - Count: 14 (36.84%)
Reason: too_expensive - Count: 8 (21.05%)
  Comment: It wasn’t working very disappointed
Reason: payment_failed - Count: 6 (15.79%)
Reason: cancellation_requested - Count: 5 (13.16%)
Reason: other - Count: 3 (7.89%)
  Comment: I want picture stories
  Comment: schlechte Qualität.
  Comment: I paid for the subscription, but every time I wanted to make a story, they gave me an error. In the end, I didn't do anything
Reason: switched_service - Count: 2 (5.26%)
```