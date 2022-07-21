# frozen_string_literal: true

module ThaiCalendar
  class Calendar
    attr_reader :birth, :hrk1
    attr_accessor :hrk2
    
    def initialize(birth)
      @birth = birth
      @hrk1 = horakun_year_thai(1, 1, birth.year)
      @hrk2 = horakun_year_thai(birth.day, birth.month, birth.year)
    end

    def summary
      "วัน#{day_thai} #{moon_pharse} #{day_of_moon} ค่ำ เดือน #{month_of_moon} ปี #{zodiac} จ.ศ.#{minor_era}"
    end
    
    def moon_pharse
      get_moon[:pharse]
    end

    def day_of_moon
      get_moon[:days]
    end
    
    def month_of_moon
      get_moon[:month]
    end

    def zodiac
      day_add = find_year_and_day[1]
      ks = (birth.year - 3) % 12
      ks = 12 if ks == 0

      unless birth.year + 543 < 2484
        ks = ks - 1 if day_add <= 118
      end

      ks = 12 if ks == 0

      return case ks
      when 0 then "กุน"
      when 1 then "ชวด"
      when 2 then "ฉลู"
      when 3 then "ขาล"
      when 4 then "เถาะ"
      when 5 then "มะโรง"
      when 6 then "มะเส็ง"
    when 7 then "มะเมีย"
      when 8 then "มะแม"
      when 9 then "วอก"
      when 10 then "ระกา"
      when 11 then "จอ"
      when 12 then "กุน"
      end
    end

    def minor_era
      validate_hrk2
      ((hrk2 - 1) * 800 + (birth.hour + ((birth.minute / 60)) * 800 / 24) - 373) / 292207
    end

    def sok
      return case minor_era % 10
      when 0 then "สัมฤทธิศก"
      when 1 then "เอกศก"
      when 2 then "โทศก"
      when 3 then "ตรีศก"
      when 4 then "จัตวาศก"
      when 5 then "เบญจศก"
      when 6 then "ฉศก"
      when 7 then "สัปตศก"
      when 8 then "อัฐศก"
      when 9 then "นพศก"
      end
    end

    def day_thai
      validate_hrk2
      d = birth.hour < 6 ? (hrk2 - 1) % 7 : hrk2 % 7

      return case d
      when 1 then "อาทิตย์"
      when 2 then "จันทร์"
      when 3 then "อังคาร"
      when 4 then "พุธ"
      when 5 then "พฤหัสบดี"
      when 6 then "ศุกร์"
      when 0 then "เสาร์"
      end
    end

    def day_inter
      validate_hrk2

      return case hrk2 % 7
      when 1 then "อาทิตย์"
      when 2 then "จันทร์"
      when 3 then "อังคาร"
      when 4 then "พุธ"
      when 5 then "พฤหัสบดี"
      when 6 then "ศุกร์"
      when 0 then "เสาร์"
      end
    end

    alias lunar_system_day day_thai
    alias solar_system_day day_inter


    private
    def horakun_year_thai(d, m, y)
      im = (12 * y) + m + 57597
      j = (2 * (im - (im/12) * 12) + 7 + 365 * im) / 12 
      j = j + d + (im/48) - 32083
      
      if j > 2299171
        j = j + (im/4800) - (im/1200) + 38
      end
      j - 1954167
    end

    def validate_hrk2
      if birth.year + 543 <  2484 and birth.month < 4
        @hrk2 = horakun_year_thai(birth.day, birth.month, birth.year + 1)
      end
    end

    def get_moon
      year_about, day_add = find_year_and_day

      case year_about
      when 1
        if day_add > 414 then day_add = day_add - 414 end
        if day_add <= 414 then days = day_add - 399; month = 1; pharse = "แรม" end
        if day_add <= 399 then days = day_add - 384; month = 1; pharse = "ขึ้น" end
        if day_add <= 384 then days = day_add - 369; month = 12; pharse = "แรม" end
        if day_add <= 369 then days = day_add - 354; month = 12; pharse = "ขึ้น" end
        if day_add <= 354 then days = day_add - 340; month = 11; pharse = "แรม" end
        if day_add <= 340 then days = day_add - 325; month = 11; pharse = "ขึ้น" end
        if day_add <= 325 then days = day_add - 310; month = 10; pharse = "แรม" end
        if day_add <= 310 then days = day_add - 295; month = 10; pharse = "ขึ้น" end
        if day_add <= 295 then days = day_add - 281; month = 9; pharse = "แรม" end
        if day_add <= 281 then days = day_add - 266; month = 9; pharse = "ขึ้น" end
        if day_add <= 266 then days = day_add - 251; month = 8; pharse = "แรม" end
        if day_add <= 251 then days = day_add - 236; month = 8; pharse = "ขึ้น" end
        if day_add <= 236 then days = day_add - 221; month = 8; pharse = "แรม" end
        if day_add <= 221 then days = day_add - 206; month = 8; pharse = "ขึ้น" end
        if day_add <= 206 then days = day_add - 192; month = 7; pharse = "แรม" end
        if day_add <= 192 then days = day_add - 177; month = 7; pharse = "ขึ้น" end
        if day_add <= 177 then days = day_add - 162; month = 6; pharse = "แรม" end
        if day_add <= 162 then days = day_add - 147; month = 6; pharse = "ขึ้น" end
        if day_add <= 147 then days = day_add - 133; month = 5; pharse = "แรม" end
        if day_add <= 133 then days = day_add - 118; month = 5; pharse = "ขึ้น" end
        if day_add <= 118 then days = day_add - 103; month = 4; pharse = "แรม" end
        if day_add <= 103 then days = day_add - 88; month = 4; pharse = "ขึ้น" end
        if day_add <= 88 then days = day_add - 74; month = 3; pharse = "แรม" end
        if day_add <= 74 then days = day_add - 59; month = 3; pharse = "ขึ้น" end
        if day_add <= 59 then days = day_add - 44; month = 2; pharse = "แรม" end
        if day_add <= 44 then days = day_add - 29; month = 2; pharse = "ขึ้น" end
        if day_add <= 29 then days = day_add - 15; month = 1; pharse = "แรม" end
        if day_add <= 15 then days = day_add; month = 1; pharse = "ขึ้น" end

      when 2
        if day_add <= 414 then days = day_add - 399; month = 2; pharse = "แรม" end
        if day_add <= 399 then days = day_add - 384; month = 2; pharse = "ขึ้น" end
        if day_add <= 384 then days = day_add - 370; month = 1; pharse = "แรม" end
        if day_add <= 370 then days = day_add - 355; month = 1; pharse = "ขึ้น" end
        if day_add <= 355 then days = day_add - 340; month = 12; pharse = "แรม" end
        if day_add <= 340 then days = day_add - 325; month = 12; pharse = "ขึ้น" end
        if day_add <= 325 then days = day_add - 311; month = 11; pharse = "แรม" end
        if day_add <= 311 then days = day_add - 296; month = 11; pharse = "ขึ้น" end
        if day_add <= 296 then days = day_add - 281; month = 10; pharse = "แรม" end
        if day_add <= 281 then days = day_add - 266; month = 10; pharse = "ขึ้น" end
        if day_add <= 266 then days = day_add - 252; month = 9; pharse = "แรม" end
        if day_add <= 252 then days = day_add - 237; month = 9; pharse = "ขึ้น" end
        if day_add <= 237 then days = day_add - 222; month = 8; pharse = "แรม" end
        if day_add <= 222 then days = day_add - 207; month = 8; pharse = "ขึ้น" end
        if day_add <= 207 then days = day_add - 192; month = 7; pharse = "แรม" end
        if day_add <= 192 then days = day_add - 177; month = 7; pharse = "ขึ้น" end
        if day_add <= 177 then days = day_add - 162; month = 6; pharse = "แรม" end
        if day_add <= 162 then days = day_add - 147; month = 6; pharse = "ขึ้น" end
        if day_add <= 147 then days = day_add - 133; month = 5; pharse = "แรม" end
        if day_add <= 133 then days = day_add - 118; month = 5; pharse = "ขึ้น" end
        if day_add <= 118 then days = day_add - 103; month = 4; pharse = "แรม" end
        if day_add <= 103 then days = day_add - 88; month = 4; pharse = "ขึ้น" end
        if day_add <= 88 then days = day_add - 74; month = 3; pharse = "แรม" end
        if day_add <= 74 then days = day_add - 59; month = 3; pharse = "ขึ้น" end
        if day_add <= 59 then days = day_add - 44; month = 2; pharse = "แรม" end
        if day_add <= 44 then days = day_add - 29; month = 2; pharse = "ขึ้น" end
        if day_add <= 29 then days = day_add - 15; month = 1; pharse = "แรม" end
        if day_add <= 15 then days = day_add; month = 1; pharse = "ขึ้น" end


      when 3
        if day_add <= 413 then days = day_add - 398; month = 2; pharse = "แรม" end
        if day_add <= 398 then days = day_add - 383; month = 2; pharse = "ขึ้น" end
        if day_add <= 383 then days = day_add - 369; month = 1; pharse = "แรม" end
        if day_add <= 369 then days = day_add - 354; month = 1; pharse = "ขึ้น" end
        if day_add <= 354 then days = day_add - 339; month = 12; pharse = "แรม" end
        if day_add <= 339 then days = day_add - 324; month = 12; pharse = "ขึ้น" end
        if day_add <= 324 then days = day_add - 310; month = 11; pharse = "แรม" end
        if day_add <= 310 then days = day_add - 295; month = 11; pharse = "ขึ้น" end
        if day_add <= 295 then days = day_add - 280; month = 10; pharse = "แรม" end
        if day_add <= 280 then days = day_add - 265; month = 10; pharse = "ขึ้น" end
        if day_add <= 265 then days = day_add - 251; month = 9; pharse = "แรม" end
        if day_add <= 251 then days = day_add - 236; month = 9; pharse = "ขึ้น" end
        if day_add <= 236 then days = day_add - 221; month = 8; pharse = "แรม" end
        if day_add <= 221 then days = day_add - 206; month = 8; pharse = "ขึ้น" end
        if day_add <= 206 then days = day_add - 192; month = 7; pharse = "แรม" end
        if day_add <= 192 then days = day_add - 177; month = 7; pharse = "ขึ้น" end
        if day_add <= 177 then days = day_add - 162; month = 6; pharse = "แรม" end
        if day_add <= 162 then days = day_add - 147; month = 6; pharse = "ขึ้น" end
        if day_add <= 147 then days = day_add - 133; month = 5; pharse = "แรม" end
        if day_add <= 133 then days = day_add - 118; month = 5; pharse = "ขึ้น" end
        if day_add <= 118 then days = day_add - 103; month = 4; pharse = "แรม" end
        if day_add <= 103 then days = day_add - 88; month = 4; pharse = "ขึ้น" end
        if day_add <= 88 then days = day_add - 74; month = 3; pharse = "แรม" end
        if day_add <= 74 then days = day_add - 59; month = 3; pharse = "ขึ้น" end
        if day_add <= 59 then days = day_add - 44; month = 2; pharse = "แรม" end
        if day_add <= 44 then days = day_add - 29; month = 2; pharse = "ขึ้น" end
        if day_add <= 29 then days = day_add - 15; month = 1; pharse = "แรม" end
        if day_add <= 15 then days = day_add; month = 1; pharse = "ขึ้น"  end
      end

      return { days: days, month: month, pharse: pharse }
    end

    def find_year_and_day
      if birth.year + 543 >= 2484
        return find_year_and_day_from_2484
      else
        return find_year_and_day_prior_2484
      end
    end

    def find_year_and_day_from_2484
      year_about, day_add = case birth.year + 543
        
      when 2484 then [3, 33]
      when 2485 then [1, 44]
      when 2486 then [3, 25]
      when 2487 then [1, 36]
      when 2488 then [2, 18]
      when 2489 then [3, 28]
      when 2490 then [1, 39]
      when 2491 then [3, 20]
      when 2492 then [2, 32]
      when 2493 then [1, 42]
      when 2494 then [3, 23]
      when 2495 then [2, 34]
      when 2496 then [1, 45]
      when 2497 then [3, 26]
      when 2498 then [3, 37]
      when 2499 then [1, 48]
      when 2500 then [2, 30]
      when 2501 then [1, 40]
      when 2502 then [3, 21]
      when 2503 then [3, 32]
      when 2504 then [1, 44]
      when 2505 then [3, 25]
      when 2506 then [2, 36]
      when 2507 then [1, 46]
      when 2508 then [3, 28]
      when 2509 then [1, 39]
      when 2510 then [3, 20]
      when 2511 then [3, 31]
      when 2512 then [1, 43]
      when 2513 then [2, 24]
      when 2514 then [3, 34]
      when 2515 then [1, 45]
      when 2516 then [2, 27]
      when 2517 then [3, 37]
      when 2518 then [1, 48]
      when 2519 then [3, 29]
      when 2520 then [1, 41]
      when 2521 then [3, 22]
      when 2522 then [2, 33]
      when 2523 then [1, 43]
      when 2524 then [3, 25]
      when 2525 then [3, 36]
      when 2526 then [1, 47]
      when 2527 then [3, 28]
      when 2528 then [1, 40]
      when 2529 then [3, 21]
      when 2530 then [2, 32]
      when 2531 then [1, 42]
      when 2532 then [3, 24]
      when 2533 then [2, 35]
      when 2534 then [1, 45]
      when 2535 then [3, 26]
      when 2536 then [1, 38]
      when 2537 then [3, 19]
      when 2538 then [3, 30]
      when 2539 then [1, 41]
      when 2540 then [2, 23]
      when 2541 then [3, 33]
      when 2542 then [1, 44]
      when 2543 then [2, 25]
      when 2544 then [3, 36]
      when 2545 then [1, 47]
      when 2546 then [3, 28]
      when 2547 then [1, 39]
      when 2548 then [2, 21]
      when 2549 then [3, 32]
      when 2550 then [1, 42]
      when 2551 then [3, 23]
      when 2552 then [2, 35]
      when 2553 then [1, 45]
      when 2554 then [3, 26]
      when 2555 then [1, 37]
      when 2556 then [3, 19]
      when 2557 then [3, 30]
      when 2558 then [1, 41]
      when 2559 then [2, 22]
      when 2560 then [3, 33]
      when 2561 then [1, 44]
      when 2562 then [3, 25]
      when 2563 then [3, 36]
      when 2564 then [1, 48]
      when 2565 then [3, 29]
      when 2566 then [1, 40]
      when 2567 then [3, 21]
      when 2568 then [2, 32]
      when 2569 then [1, 42]
      when 2570 then [3, 23]
      when 2571 then [3, 34]
      when 2572 then [1, 56]
      when 2573 then [3, 27]
      when 2574 then [1, 38]
      when 2575 then [2, 19]
      when 2576 then [3, 31]
      when 2577 then [1, 41]
      when 2578 then [2, 22]
      when 2579 then [3, 32]
      when 2580 then [1, 44]
      when 2581 then [3, 25]
      when 2582 then [3, 36]
      when 2583 then [1, 47]
      when 2584 then [3, 29]
      when 2585 then [1, 40]
      when 2586 then [2, 21]
      when 2587 then [3, 31]
      when 2588 then [1, 43]
      when 2589 then [2, 24]
      when 2590 then [3, 34]
      when 2591 then [1, 45]
      when 2592 then [3, 27]
      when 2593 then [1, 38]
      when 2594 then [3, 19]
      when 2595 then [2, 30]
      when 2596 then [1, 41]
      when 2597 then [3, 22]
      when 2598 then [3, 33]
      when 2599 then [1, 44]
      when 2600 then [3, 26]
      when 2601 then [2, 37]
      when 2602 then [1, 47]
      when 2603 then [3, 28]
      when 2604 then [1, 40]
      when 2605 then [2, 21]
      when 2606 then [3, 31]
      when 2607 then [1, 42]
      when 2608 then [3, 24]
      when 2609 then [3, 35]
      when 2610 then [1, 46]
      when 2611 then [2, 27]
      when 2612 then [1, 38]
      when 2613 then [3, 19]
      when 2614 then [2, 30]
      when 2615 then [1, 40]
      when 2616 then [3, 22]
      when 2617 then [3, 33]
      when 2618 then [1, 44]
      when 2619 then [2, 25]
      when 2620 then [3, 36]
      end

      day_add = day_add + (hrk2 - hrk1)
      day_add = day_add - 1 if birth.hour < 6 
      
      return year_about, day_add
    end

    def find_year_and_day_prior_2484
      year = birth.month < 4 ? birth.year  + 1 : birth.year
      year += 543

      year_about, day_add = case year
      when 2300 then [3, 0]
      when 2301 then [1, 52]
      when 2302 then [2, 33]
      when 2303 then [1, 43]
      when 2304 then [3, 25]
      when 2305 then [3, 36]
      when 2306 then [1, 47]
      when 2307 then [2, 28]
      when 2308 then [3, 39]
      when 2309 then [1, 50]
      when 2310 then [2, 31]
      when 2311 then [1, 41]
      when 2312 then [3, 23]
      when 2313 then [3, 34]
      when 2314 then [1, 45]
      when 2315 then [3, 26]
      when 2316 then [2, 38]
      when 2317 then [1, 48]
      when 2318 then [3, 29]
      when 2319 then [3, 40]
      when 2320 then [1, 52]
      when 2321 then [2, 33]
      when 2322 then [1, 43]
      when 2323 then [3, 24]
      when 2324 then [3, 36]
      when 2325 then [1, 47]
      when 2326 then [3, 28]
      when 2327 then [2, 39]
      when 2328 then [1, 50]
      when 2329 then [3, 31]
      when 2330 then [1, 42]
      when 2331 then [3, 23]
      when 2332 then [2, 35]
      when 2333 then [1, 45]
      when 2334 then [3, 26]
      when 2335 then [3, 37]
      when 2336 then [1, 49]
      when 2337 then [2, 30]
      when 2338 then [3, 40]
      when 2339 then [1, 51]
      when 2340 then [3, 33]
      when 2341 then [1, 44]
      when 2342 then [2, 25]
      when 2343 then [3, 35]
      when 2344 then [1, 46]
      when 2345 then [3, 27]
      when 2346 then [2, 38]
      when 2347 then [1, 48]
      when 2348 then [3, 30]
      when 2349 then [1, 41]
      when 2350 then [3, 22]
      when 2351 then [3, 33]
      when 2352 then [1, 45]
      when 2353 then [2, 26]
      when 2354 then [3, 36]
      when 2355 then [1, 47]
      when 2356 then [3, 29]
      when 2357 then [2, 40]
      when 2358 then [1, 50]
      when 2359 then [3, 31]
      when 2360 then [1, 43]
      when 2361 then [3, 24]
      when 2362 then [2, 35]
      when 2363 then [1, 45]
      when 2364 then [3, 27]
      when 2365 then [3, 38]
      when 2366 then [1, 49]
      when 2367 then [3, 30]
      when 2368 then [1, 42]
      when 2369 then [2, 23]
      when 2370 then [3, 33]
      when 2371 then [1, 44]
      when 2372 then [3, 26]
      when 2373 then [2, 37]
      when 2374 then [1, 47]
      when 2375 then [3, 28]
      when 2376 then [3, 40]
      when 2377 then [1, 51]
      when 2378 then [2, 32]
      when 2379 then [1, 42]
      when 2380 then [3, 24]
      when 2381 then [2, 35]
      when 2382 then [1, 45]
      when 2383 then [3, 26]
      when 2384 then [3, 38]
      when 2385 then [1, 49]
      when 2386 then [3, 30]
      when 2387 then [1, 41]
      when 2388 then [3, 23]
      when 2389 then [2, 34]
      when 2390 then [1, 44]
      when 2391 then [3, 25]
      when 2392 then [2, 37]
      when 2393 then [1, 47]
      when 2394 then [3, 28]
      when 2395 then [3, 39]
      when 2396 then [1, 51]
      when 2397 then [2, 32]
      when 2398 then [1, 42]
      when 2399 then [3, 35]
      when 2400 then [3, 35]
      when 2401 then [1, 46]
      when 2402 then [3, 27]
      when 2403 then [2, 38]
      when 2404 then [1, 49]
      when 2405 then [3, 30]
      when 2406 then [1, 41]
      when 2407 then [3, 22]
      when 2408 then [2, 34]
      when 2409 then [1, 44]
      when 2410 then [3, 25]
      when 2411 then [3, 36]
      when 2412 then [1, 48]
      when 2413 then [3, 29]
      when 2414 then [2, 40]
      when 2415 then [1, 50]
      when 2416 then [3, 32]
      when 2417 then [1, 43]
      when 2418 then [3, 24]
      when 2419 then [2, 35]
      when 2420 then [1, 46]
      when 2421 then [3, 27]
      when 2422 then [3, 38]
      when 2423 then [1, 49]
      when 2424 then [2, 31]
      when 2425 then [1, 41]
      when 2426 then [3, 22]
      when 2427 then [3, 33]
      when 2428 then [1, 45]
      when 2429 then [3, 26]
      when 2430 then [2, 37]
      when 2431 then [1, 47]
      when 2432 then [3, 29]
      when 2433 then [1, 40]
      when 2434 then [3, 21]
      when 2435 then [2, 32]
      when 2436 then [1, 43]
      when 2437 then [3, 24]
      when 2438 then [3, 35]
      when 2439 then [1, 46]
      when 2440 then [3, 28]
      when 2441 then [2, 39]
      when 2442 then [1, 49]
      when 2443 then [3, 30]
      when 2444 then [1, 41]
      when 2445 then [3, 22]
      when 2446 then [2, 33]
      when 2447 then [1, 43]
      when 2448 then [3, 25]
      when 2449 then [3, 36]
      when 2450 then [1, 47]
      when 2451 then [2, 28]
      when 2452 then [1, 39]
      when 2453 then [3, 20]
      when 2454 then [3, 31]
      when 2455 then [1, 42]
      when 2456 then [3, 24]
      when 2457 then [2, 35]
      when 2458 then [1, 45]
      when 2459 then [3, 26]
      when 2460 then [2, 38]
      when 2461 then [1, 48]
      when 2462 then [3, 29]
      when 2463 then [1, 40]
      when 2464 then [3, 22]
      when 2465 then [3, 33]
      when 2466 then [1, 44]
      when 2467 then [3, 25]
      when 2468 then [2, 37]
      when 2469 then [1, 47]
      when 2470 then [3, 28]
      when 2471 then [1, 39]
      when 2472 then [2, 21]
      when 2473 then [3, 31]
      when 2474 then [1, 42]
      when 2475 then [3, 23]
      when 2476 then [2, 35]
      when 2477 then [1, 45]
      when 2478 then [3, 26]
      when 2479 then [2, 37]
      when 2480 then [1, 48]
      when 2481 then [3, 29]
      when 2482 then [1, 40]
      when 2483 then [3, 21]
      else
        [0, 0]
      end

      day_add = day_add + (hrk2 - hrk1)
      day_add = day_add - 1 if birth.hour < 6 

      return year_about, day_add
    end
  end
end
