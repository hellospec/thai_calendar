# frozen_string_literal: true

require "test_helper"

class TestCalendar < Minitest::Test
  describe "message" do
    it "can print" do
      birth_date = DateTime.new(2017, 9, 1, 12, 00)
      thai_date = ThaiCalendar::Calendar.new(birth_date)

      expected = "วันศุกร์ ขึ้น 11 ค่ำ เดือน 10 ปี ระกา จ.ศ.1379"
      assert_equal expected, thai_date.to_s
    end
  end

  describe "Edge cases of this module" do
    it "works after 2483 BE (1940 CE)" do
      birth_date = DateTime.new(2017, 9, 1, 12, 00)
      thai_date = ThaiCalendar::Calendar.new(birth_date)

      assert_equal thai_date.moon_pharse, "ขึ้น"
      assert_equal thai_date.day_of_moon, 11
      assert_equal thai_date.zodiac, "ระกา"
      assert_equal thai_date.minor_era, 1379
      assert_equal thai_date.sok, "นพศก"
      assert_equal thai_date.lunar_system_day, "ศุกร์"
      assert_equal thai_date.solar_system_day, "ศุกร์"
    end

    it "works before 2483 BE (1941 CE)" do
      birth_date = DateTime.new(1932, 6, 24, 12, 00)
      thai_date = ThaiCalendar::Calendar.new(birth_date) 

      assert_equal thai_date.moon_pharse, "แรม"
      assert_equal thai_date.day_of_moon, 6
      assert_equal thai_date.zodiac, "วอก"
      assert_equal thai_date.minor_era, 1294
      assert_equal thai_date.sok, "จัตวาศก"
      assert_equal thai_date.lunar_system_day, "ศุกร์"
      assert_equal thai_date.solar_system_day, "ศุกร์"
    end

    it "works at begining of 2484 BE" do
      birth_date = DateTime.new(1941, 1, 1, 00, 00)
      thai_date = ThaiCalendar::Calendar.new(birth_date)

      assert_equal thai_date.moon_pharse, "ขึ้น"
      assert_equal thai_date.day_of_moon, 3
      assert_equal thai_date.zodiac, "มะโรง"
      assert_equal thai_date.minor_era, 1302
      assert_equal thai_date.sok, "โทศก"
      assert_equal thai_date.lunar_system_day, "อังคาร"
      assert_equal thai_date.solar_system_day, "พุธ"
    end

    it "works at end of 2483 BE" do
      birth_date = DateTime.new(1940, 12, 31, 23, 59)
      thai_date = ThaiCalendar::Calendar.new(birth_date)

      assert_equal thai_date.moon_pharse, "ขึ้น"
      assert_equal thai_date.day_of_moon, 3
      assert_equal thai_date.zodiac, "มะโรง"
      assert_equal thai_date.minor_era, 1302
      assert_equal thai_date.sok, "โทศก"
      assert_equal thai_date.lunar_system_day, "อังคาร"
      assert_equal thai_date.solar_system_day, "อังคาร"
    end

    it "works at 1st April of 2300 BE" do
      birth_date = DateTime.new(1757, 4, 1, 0, 0)
      thai_date = ThaiCalendar::Calendar.new(birth_date)

      assert_equal thai_date.moon_pharse, "ขึ้น"
      assert_equal thai_date.day_of_moon, 1
      assert_equal thai_date.zodiac, "ฉลู"
      assert_equal thai_date.minor_era, 1118
      assert_equal thai_date.sok, "อัฐศก"
      assert_equal thai_date.lunar_system_day, "พฤหัสบดี"
      assert_equal thai_date.solar_system_day, "ศุกร์"
    end

    it "works at beginning of 2300 BE" do
      birth_date = DateTime.new(1757, 1, 1, 0, 0)
      thai_date = ThaiCalendar::Calendar.new(birth_date)

      assert_equal thai_date.moon_pharse, "แรม"
      assert_equal thai_date.day_of_moon, 7
      assert_equal thai_date.zodiac, "ฉลู"
      assert_equal thai_date.minor_era, 1119
      assert_equal thai_date.sok, "นพศก"
      assert_equal thai_date.lunar_system_day, "เสาร์"
      assert_equal thai_date.solar_system_day, "อาทิตย์"
    end
  end

  describe "General cases" do
    it "testcase #1 Hora Ram" do
      birth_date = DateTime.new(1987, 1, 15, 7, 0)
      thai_date = ThaiCalendar::Calendar.new(birth_date)

      assert_equal thai_date.moon_pharse, "แรม"
      assert_equal thai_date.day_of_moon, 2
      assert_equal thai_date.zodiac, "ขาล"
      assert_equal thai_date.minor_era, 1348
      assert_equal thai_date.sok, "อัฐศก"
      assert_equal thai_date.lunar_system_day, "พฤหัสบดี"
      assert_equal thai_date.solar_system_day, "พฤหัสบดี"
    end

    it "testcase #2 Hora Ram" do
      birth_date = DateTime.new(1970, 7, 26, 7, 0)
      thai_date = ThaiCalendar::Calendar.new(birth_date)

      assert_equal thai_date.moon_pharse, "แรม"
      assert_equal thai_date.day_of_moon, 8
      assert_equal thai_date.zodiac, "จอ"
      assert_equal thai_date.minor_era, 1332
      assert_equal thai_date.sok, "โทศก"
      assert_equal thai_date.lunar_system_day, "อาทิตย์"
      assert_equal thai_date.solar_system_day, "อาทิตย์"
    end

    it "testcase #3 Hora Ram" do
      birth_date = DateTime.new(1974, 9, 27, 7, 0)
      thai_date = ThaiCalendar::Calendar.new(birth_date)

      assert_equal thai_date.moon_pharse, "ขึ้น"
      assert_equal thai_date.day_of_moon, 11
      assert_equal thai_date.zodiac, "ขาล"
      assert_equal thai_date.minor_era, 1336
      assert_equal thai_date.sok, "ฉศก"
      assert_equal thai_date.lunar_system_day, "ศุกร์"
      assert_equal thai_date.solar_system_day, "ศุกร์"
    end

    it "testcase #4 Hora Ram" do
      birth_date = DateTime.new(1983, 1, 10, 7, 0)
      thai_date = ThaiCalendar::Calendar.new(birth_date)

      assert_equal thai_date.moon_pharse, "แรม"
      assert_equal thai_date.day_of_moon, 12
      assert_equal thai_date.zodiac, "จอ"
      assert_equal thai_date.minor_era, 1344
      assert_equal thai_date.sok, "จัตวาศก"
      assert_equal thai_date.lunar_system_day, "จันทร์"
      assert_equal thai_date.solar_system_day, "จันทร์"
    end

    it "testcase #5 Hora Ram" do
      birth_date = DateTime.new(1976, 4, 17, 7, 0)
      thai_date = ThaiCalendar::Calendar.new(birth_date)

      assert_equal thai_date.moon_pharse, "แรม"
      assert_equal thai_date.day_of_moon, 3
      assert_equal thai_date.zodiac, "มะโรง"
      assert_equal thai_date.minor_era, 1338
      assert_equal thai_date.sok, "อัฐศก"
      assert_equal thai_date.lunar_system_day, "เสาร์"
      assert_equal thai_date.solar_system_day, "เสาร์"
    end
  end
end

