package com.monapp.model;

import jakarta.persistence.*;

@Entity
@Table(name = "qcm")
public class Qcm {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "num_quest")
    private Integer numQuest;

    @Column(name = "question", nullable = false)
    private String question;

    @Column(name = "reponse1", nullable = false)
    private String reponse1;

    @Column(name = "reponse2", nullable = false)
    private String reponse2;

    @Column(name = "reponse3", nullable = false)
    private String reponse3;

     @Column(name = "reponse4", nullable = false)
    private String reponse4;

    @Column(name = "bonne_reponse", nullable = false)
    private Integer bonneReponse;

    public Qcm() {}

    public Qcm(String question, String reponse1, String reponse2, 
        String reponse3, String reponse4, Integer bonneReponse)
    {
        this.question = question;
        this.reponse1 = reponse1;
        this.reponse2 = reponse2;
        this.reponse3 = reponse3;
        this.reponse4 = reponse4;
        this.bonneReponse = bonneReponse;

    }

    public Integer getNumQuest() { return numQuest; }
    public void setNumQuest(Integer numQuest) { this.numQuest = numQuest; }

    public String getQuestion() { return question; }
    public void setQuestion(String question) { this.question = question; }

    public String getReponse1() { return reponse1; }
    public void setReponse1(String reponse1) { this.reponse1 = reponse1; }

    public String getReponse2() { return reponse2; }
    public void setReponse2(String reponse2) { this.reponse2 = reponse2; }

    public String getReponse3() { return reponse3; }
    public void setReponse3(String reponse3) { this.reponse3 = reponse3; }

    public String getReponse4() { return reponse4; }
    public void setReponse4(String reponse4) { this.reponse4 = reponse4; }

    public Integer getBonneReponse() { return bonneReponse; }
    public void setBonneReponse(Integer bonneReponse) { this.bonneReponse = bonneReponse; }
}
