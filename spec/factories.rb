Factory.define :user do |user|
	user.name										"Devin Goofball"
	user.email									"DG@gmail.com"
	user.password								"foobar"
	user.password_confirmation 	"foobar"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :student do |student|
  student.name "Kid A"
  student.assignment "Math homework"
  student.instructions "Do it all"
end
