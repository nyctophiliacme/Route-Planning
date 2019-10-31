/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * @author PRANSH
 */
package DataPackage;

import java.util.List;

public class Data {

    private List<String> places;
    private List<String> crimes;
    private List<String> times;

    public List<String> getPlaces() {
        return places;
    }

    public void setPlaces(List<String> places) {
        this.places = places;
    }

    public List<String> getCrimes() {
        return crimes;
    }

    public void setCrimes(List<String> crimes) {
        this.crimes = crimes;
    }

    public List<String> getTimes() {
        return times;
    }

    public void setTimes(List<String> times) {
        this.times = times;
    }

}