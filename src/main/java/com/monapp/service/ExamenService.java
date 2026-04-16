package com.monapp.service;

import com.monapp.model.Examen;
import com.monapp.repository.ExamenRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import java.util.List;

@ApplicationScoped
public class ExamenService {
    @Inject
    private ExamenRepository repoExam;

    public void ajouterExamen(Examen exam)
    {
        repoExam.save(exam);
    }

    public List<Examen> listerExamen()
    {
        return repoExam.findAll();
    }
    public Examen trouverParId(Integer id)
    {
        return repoExam.findById(id);
    }
    public void supprimerExam(Integer id)
    {
        repoExam.delete(id);
    }

    public Long countExamen()
    {
        return repoExam.countExam();
    }
    public Long plus5()
    {
        return repoExam.countPlusDe5();
    }

    public Long moin5()
    {
        return repoExam.countMoinsDe5();
    }
    public Double moyenne()
    {
        return repoExam.getMoyenneGenerale();
    }
}
