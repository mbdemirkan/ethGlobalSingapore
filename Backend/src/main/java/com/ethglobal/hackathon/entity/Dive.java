package com.ethglobal.hackathon.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.util.UUID;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
public class Dive {
      
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @JdbcTypeCode(SqlTypes.VARCHAR)
    private UUID id; 
    private String diverAddress;
    private String placeId;
    private String diveMasterAddress;
    private String nftAddress;

    @Override
    public String toString() {
        return "Dive{" +
                "id=" + id +
                ", diverAddress='" + diverAddress + '\'' +
                ", placeId='" + placeId + '\'' +
                ", diveMasterAddress='" + diveMasterAddress + '\'' +
                ", nftAddress='" + nftAddress + '\'' +
                '}';
    }
}
