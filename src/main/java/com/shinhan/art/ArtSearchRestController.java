package com.shinhan.art;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.shinhan.VO.ArtsDTO;

@RestController
@RequestMapping("/artSearch")
public class ArtSearchRestController {

    @Autowired
    private ArtSearchService artworkService;

    @GetMapping("/rangefilter")
    public List<ArtsDTO> getArtByPriceRange(@RequestParam int minPrice, @RequestParam int maxPrice) {
        return artworkService.getArtByPriceRange(minPrice, maxPrice);
    }
}