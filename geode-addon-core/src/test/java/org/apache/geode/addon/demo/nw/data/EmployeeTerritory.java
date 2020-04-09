package org.apache.geode.addon.demo.nw.data;

import org.apache.geode.pdx.PdxReader;
import org.apache.geode.pdx.PdxSerializable;
import org.apache.geode.pdx.PdxWriter;

public class EmployeeTerritory implements PdxSerializable
{
	private String employeeId;
	private String territoryId;

	public EmployeeTerritory()
	{
	}

	public void setEmployeeId(String employeeId) {
		this.employeeId=employeeId;
	}

	public String getEmployeeId() {
		return this.employeeId;
	}

	public void setTerritoryId(String territoryId) {
		this.territoryId=territoryId;
	}

	public String getTerritoryId() {
		return this.territoryId;
	}

	@Override
	public String toString()
	{
		return "[employeeId=" + this.employeeId
			 + ", territoryId=" + this.territoryId + "]";
	}

	@Override
	public void toData(PdxWriter writer) {
		writer.writeString("employeeId", employeeId);
		writer.writeString("territoryId", territoryId);
	}

	@Override
	public void fromData(PdxReader reader) {
		this.employeeId = reader.readString("employeeId");
		this.territoryId = reader.readString("territoryId");
	}
}
