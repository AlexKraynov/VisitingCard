package ru.alexkraynov.glossary.logic;

import java.util.Collection;

public class GlossaryFrame {

    private Collection strike;
    private String search;
    private String lang;

    public String getLang() {
        return lang;
    }

    public void setLang(String lang) {
        this.lang = lang;
    }

    public String getSearch() {
        return search;
    }

    public void setSearch(String search) {
        this.search = search;
    }

    public Collection getStrike() {
        return strike;
    }

    public void setStrike(Collection strike) {
        this.strike = strike;
    }
}
