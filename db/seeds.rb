# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create([
  {
    email: 'jswood@tamu.edu',
    full_name: 'Josh test admin',
    admin: true
  }
]
           )

if Page.count < 3
  Page.create([
    {
      page_name: 'about',
      page_data: '{
        "purpose" : "The purpose of this organization shall be to advocate for maternal and child public health-related issues for all students.",

        "goal" : "The goal will be to enhance the quality and scope of maternal and child public health by educating students and providing them with opportunities to impact the community positively.",

        "membership_dues" : "Membership is open to any Aggie (undergraduate or graduate/ any concentration). Dues are $15 one time.",

        "expectations" : [
          "Attend monthly meetings",
          "Respond in GroupMe when needed (ex. polls)",
          "Attend supplemental meetings if able",
          "Respect opinions of fellow members"],

          "what_we_do" : [
          "Field Trips",
          "Volunteering",
          "Book Club",
          "Guest Speakers",
          "Donation Drives",
          "Profit Shares",
          "Craft Events",
          "Socials",
          "Research Opportunities",
          "Certificate Opportunities"]
  }'
    },
    {
      page_name: 'contact',
      page_data: '{
        "description" : "Below you can find our email and social links, be sure to follow MCHSO on Facebook!",

        "links" : {
          "Email" : "mailto:hannahbartosh@tamu.edu",
          "facebook" : "https://www.facebook.com/MCHSOaggies/",
          "store" : "https://tamu.estore.flywire.com/products?storeCatalog=7302",
          "instagram" : "https://www.instagram.com/mchsoaggies/?hl=en"
        }
  }'
    },
    {
      page_name: 'home',
      page_data: '{
        "title" : "Welcome to the Maternal and Child Health Student Organization",

        "blurb" : "Welcome blurb, summary of the history and basic information of the org."
  }'
    }
  ]
             )
end

PointsType.create([
  {
    name: 'member',
    score: 1,
  },
  {
    name: 'social',
    score: 1,
  },
  {
    name: 'philanthropy',
    score: 1,
  }
])
