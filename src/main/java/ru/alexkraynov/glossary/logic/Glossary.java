package ru.alexkraynov.glossary.logic;

public class Glossary {

    private int num;
    private String name;

    public Glossary() {

    }

    public Glossary(int num, String name) {
        this.num = num;
        this.name = name;
    }

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
